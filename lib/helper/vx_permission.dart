import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 权限管理工具类（兼容多机型）
/// 功能：
/// - 根据设备自动选择合适的“存储”权限（Android 11+ 使用 manageExternalStorage）
/// - 在请求前弹窗说明权限名称与用途，用户可确认或取消
/// - 对永久拒绝情况提示进入设置页
/// - 批量请求时仅对未授权项显示弹窗
/// - 授权后缓存标记，已授权项再次进入页面不再弹窗（同时以系统实际状态为准，若用户在系统设置撤销权限，则以系统状态为准）
class VXPermission {
  VXPermission._();
  static final VXPermission instance = VXPermission._();

  Permission? _cachedStoragePermission;

  static const String _prefsPrefix = 'vx_perm_';

  /// 权限名称（友好显示）
  static String permissionLabel(Permission permission) {
    switch (permission) {
      case Permission.microphone:
        return '麦克风';
      case Permission.camera:
        return '相机';
      case Permission.photos:
      case Permission.mediaLibrary:
        return '照片/媒体库';
      case Permission.storage:
      case Permission.manageExternalStorage:
        return '存储';
      case Permission.location:
      case Permission.locationAlways:
      case Permission.locationWhenInUse:
        return '位置';
      case Permission.contacts:
        return '通讯录';
      case Permission.notification:
        return '通知';
      case Permission.sms:
        return '短信';
      case Permission.phone:
        return '电话';
      default:
        return permission.toString().split('.').last;
    }
  }

  /// 权限用途说明（在请求前用于弹窗）
  static String permissionPurpose(Permission permission) {
    switch (permission) {
      case Permission.microphone:
        return '需要录音或语音输入功能';
      case Permission.camera:
        return '需要拍照或视频录制功能';
      case Permission.photos:
      case Permission.mediaLibrary:
        return '需要访问相册或媒体库以选择/保存图片与视频';
      case Permission.storage:
      case Permission.manageExternalStorage:
        return '需要读取或保存文件到设备存储';
      case Permission.location:
      case Permission.locationAlways:
      case Permission.locationWhenInUse:
        return '需要获取位置信息以提供定位服务';
      case Permission.contacts:
        return '需要读取联系人以完成相关功能';
      case Permission.notification:
        return '需要发送推送/本地通知';
      case Permission.sms:
        return '需要读写短信以完成通讯相关功能';
      case Permission.phone:
        return '需要拨打电话或读取通话状态';
      default:
        return '需要此权限以完成相关功能';
    }
  }

  /// 根据当前设备决定使用哪种“存储”权限（Android 特殊处理）
  Future<Permission> resolveStoragePermission() async {
    if (_cachedStoragePermission != null) return _cachedStoragePermission!;
    if (!Platform.isAndroid) {
      _cachedStoragePermission = Permission.storage;
      return _cachedStoragePermission!;
    }
    try {
      final info = await DeviceInfoPlugin().androidInfo;
      final sdk = info.version.sdkInt;
      if (sdk >= 30) {
        _cachedStoragePermission = Permission.manageExternalStorage;
      } else {
        _cachedStoragePermission = Permission.storage;
      }
      return _cachedStoragePermission!;
    } catch (_) {
      _cachedStoragePermission = Permission.storage;
      return _cachedStoragePermission!;
    }
  }

  String _prefKeyFor(Permission permission) => '$_prefsPrefix${permission.toString()}';

  Future<void> _setGrantedFlag(Permission permission, bool granted) async {
    try {
      final sp = await SharedPreferences.getInstance();
      await sp.setBool(_prefKeyFor(permission), granted);
    } catch (_) {}
  }

  Future<bool> _getGrantedFlag(Permission permission) async {
    try {
      final sp = await SharedPreferences.getInstance();
      return sp.getBool(_prefKeyFor(permission)) ?? false;
    } catch (_) {
      return false;
    }
  }

  /// 检查单个权限状态
  Future<PermissionStatus> checkPermission(Permission permission) async {
    if (permission == Permission.storage) {
      permission = await resolveStoragePermission();
    }
    return await permission.status;
  }

  /// 在请求前展示说明弹窗，用户确认后请求权限
  /// 返回：true 表示授权成功，false 表示未授权
  Future<bool> requestPermissionWithDialog({
    required BuildContext context,
    required Permission permission,
    String? title,
    String? purpose,
    String confirmText = '去允许',
    String cancelText = '取消',
  }) async {
    if (permission == Permission.storage) {
      permission = await resolveStoragePermission();
    }

    final current = await permission.status;
    if (current.isGranted) {
      // 把授权结果缓存，避免重复弹窗（同时系统状态为准）
      await _setGrantedFlag(permission, true);
      return true;
    }

    // 如果之前已缓存为已授权但系统当前非授权，则不使用缓存，仍需请求/提示
    final cached = await _getGrantedFlag(permission);
    if (cached && current.isGranted) {
      return true;
    }

    // 如果是永久拒绝，直接引导到设置页
    if (current.isPermanentlyDenied) {
      final open = await _showOpenSettingsDialog(context, permission);
      return open;
    }

    // 显示说明弹窗
    final label = title ?? permissionLabel(permission);
    final desc = purpose ?? permissionPurpose(permission);
    final confirm = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          title: Text('允许访问 $label 吗？'),
          content: Text(desc),
          actions: [
            TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: Text(cancelText)),
            ElevatedButton(onPressed: () => Navigator.of(ctx).pop(true), child: Text(confirmText)),
          ],
        );
      },
    );

    if (confirm != true) return false;

    // 请求权限
    final status = await permission.request();
    final granted = status.isGranted;
    if (granted) {
      await _setGrantedFlag(permission, true);
    } else {
      // 若未授权则清除缓存标记
      await _setGrantedFlag(permission, false);
    }

    if (status.isGranted) return true;

    if (status.isPermanentlyDenied) {
      final open = await _showOpenSettingsDialog(context, permission);
      return open;
    }

    return false;
  }

  /// 批量请求权限，先弹窗列出需要的权限和用途（可自定义文字）
  /// 返回 Map<Permission, bool> 表示每个（已解析后的）权限是否被授权
  Future<Map<Permission, bool>> requestMultipleWithDialog({
    required BuildContext context,
    required List<Permission> permissions,
    String title = '需要以下权限',
    String confirmText = '允许',
    String cancelText = '取消',
  }) async {
    // 处理 storage 替换并去重
    final resolved = <Permission>[];
    for (var p in permissions) {
      if (p == Permission.storage) {
        resolved.add(await resolveStoragePermission());
      } else {
        resolved.add(p);
      }
    }
    final unique = resolved.toSet().toList();

    // 先检查当前状态，筛选出未授权的权限
    final notGranted = <Permission>[];
    for (final p in unique) {
      final status = await p.status;
      if (!status.isGranted) {
        notGranted.add(p);
      } else {
        // 缓存已授权标记
        await _setGrantedFlag(p, true);
      }
    }

    // 如果全部已授权，直接返回全部 true（不会弹窗）
    if (notGranted.isEmpty) {
      return {for (var p in unique) p: true};
    }

    // 构建说明文本仅针对未授权项
    final buffer = StringBuffer();
    for (final p in notGranted) {
      buffer.writeln('• ${permissionLabel(p)}：${permissionPurpose(p)}');
    }

    final proceed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(child: Text(buffer.toString())),
          actions: [
            TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: Text(cancelText)),
            ElevatedButton(onPressed: () => Navigator.of(ctx).pop(true), child: Text(confirmText)),
          ],
        );
      },
    );

    if (proceed != true) {
      return {for (var p in unique) p: false};
    }

    // 请求未授权的权限
    final results = <Permission, bool>{};
    final statuses = await notGranted.request();

    // 合并结果：先把已授权的标记设为 true
    for (final p in unique) {
      results[p] = false;
    }

    statuses.forEach((p, s) async {
      final granted = s.isGranted;
      results[p] = granted;
      await _setGrantedFlag(p, granted);
    });

    // 对于之前已授权的权限，保持 true
    for (final p in unique) {
      if (results[p] == null || results[p] == false) {
        final s = await p.status;
        if (s.isGranted) {
          results[p] = true;
          await _setGrantedFlag(p, true);
        }
      }
    }

    return results;
  }

  /// 如果权限被永久拒绝，则弹窗引导用户进入设置页
  Future<bool> _showOpenSettingsDialog(
    BuildContext context,
    Permission permission, {
    String title = '权限被禁用',
    String contentPrefix = '请在系统设置中允许',
  }) async {
    final label = permissionLabel(permission);
    final opened = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          title: Text(title),
          content: Text('$contentPrefix $label 的权限，以保证相关功能可用。是否前往设置？'),
          actions: [
            TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('取消')),
            ElevatedButton(onPressed: () => Navigator.of(ctx).pop(true), child: const Text('前往设置')),
          ],
        );
      },
    );

    if (opened != true) return false;
    return await openAppSettings();
  }

  /// 直接打开应用设置页
  Future<bool> openSettings() async {
    return await openAppSettings();
  }
}
