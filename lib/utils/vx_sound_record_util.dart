import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audio_session/audio_session.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xmvx/helper/vx_global.dart';
import 'package:xmvx/helper/vx_permission.dart';

class VxSoundRecorderUtil {
  FlutterSoundRecorder? _recorder;
  bool _isOpened = false;
  String? _filePath;
  bool _isInitializing = false;
  bool _isRecording = false;
  StreamSubscription? _recorderSubscription;
  final _recordingController = StreamController<double>.broadcast();

  Stream<double> get onProgress => _recordingController.stream;

  /// 预初始化录音器
  Future<bool> preInitialize(BuildContext context) async {
    if (_isOpened) return true;
    if (_isInitializing) return false;

    _isInitializing = true;
    try {
      final results = await VXPermission.instance.requestMultipleWithDialog(
        context: context,
        permissions: [Permission.microphone],
      );
      results.forEach((p, ok) {
        if (!ok) {
          showToast('${VXPermission.permissionLabel(p)}:  权限未授权,录音功能无法使用');
        }
      });
      // 在后台线程配置音频会话
      await Future(() async {
        final session = await AudioSession.instance;
        await session.configure(
          const AudioSessionConfiguration(
            avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
            avAudioSessionMode: AVAudioSessionMode.defaultMode,
            avAudioSessionRouteSharingPolicy: AVAudioSessionRouteSharingPolicy.defaultPolicy,
            avAudioSessionSetActiveOptions:
                AVAudioSessionSetActiveOptions.notifyOthersOnDeactivation,
          ),
        );
      });

      // 初始化录音器
      _recorder = FlutterSoundRecorder();
      await _recorder?.openRecorder();

      // 设置录音状态监听
      _recorder?.setSubscriptionDuration(const Duration(milliseconds: 100));

      _isOpened = true;
      return true;
    } catch (e) {
      debugPrint('初始化录音器失败: $e');
      _isOpened = false;
      return false;
    } finally {
      _isInitializing = false;
    }
  }

  /// 开始录音
  Future<bool> startRecord(BuildContext context) async {
    if (_isRecording) return false;

    try {
      // 确保录音器已初始化
      if (!_isOpened && !await preInitialize(context)) {
        return false;
      }

      // 生成文件路径
      final dir = await getTemporaryDirectory();
      final name = 'vx_record_${DateTime.now().millisecondsSinceEpoch}.aac';
      _filePath = '${dir.path}/$name';

      // 设置录音进度监听
      _recorderSubscription?.cancel();
      _recorderSubscription = _recorder?.onProgress?.listen((e) {
        _recordingController.add(e.decibels ?? 0);
      });

      // 在后台线程开始录音
      await Future(() async {
        await _recorder?.startRecorder(
          toFile: _filePath,
          codec: Codec.aacADTS,
          audioSource: AudioSource.microphone,
          sampleRate: 44100,
          bitRate: 128000,
        );
      });

      _isRecording = true;
      return true;
    } catch (e) {
      debugPrint('开始录音失败: $e');
      _isRecording = false;
      return false;
    }
  }

  /// 停止录音并返回文件路径
  Future<String?> stopAndSave() async {
    if (!_isRecording || !_isOpened || _recorder == null) return null;
    try {
      await _recorder?.stopRecorder();
      _isRecording = false;
      _recorderSubscription?.cancel();
      _recorderSubscription = null;

      if (_filePath != null && File(_filePath!).existsSync()) {
        return _filePath;
      }
    } catch (e) {
      debugPrint('停止录音失败: $e');
    }
    return null;
  }

  /// 取消录音
  Future<void> cancelRecord() async {
    if (!_isOpened || _recorder == null) return;

    try {
      if (_isRecording) {
        await _recorder?.stopRecorder();
        _isRecording = false;
      }

      _recorderSubscription?.cancel();
      _recorderSubscription = null;

      if (_filePath != null) {
        final file = File(_filePath!);
        if (await file.exists()) {
          await file.delete();
        }
        _filePath = null;
      }
    } catch (e) {
      debugPrint('取消录音失败: $e');
    }
  }

  /// 释放资源
  Future<void> dispose() async {
    try {
      await cancelRecord();
      if (_isOpened && _recorder != null) {
        await _recorder?.closeRecorder();
        _recorder = null;
        _isOpened = false;
      }
      await _recordingController.close();
    } catch (e) {
      debugPrint('释放录音器资源失败: $e');
    }
  }

  /// 是否正在录音
  bool get isRecording => _isRecording;
}
