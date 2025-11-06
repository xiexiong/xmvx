import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xmvx/helper/vx_permission.dart';

/// 视频录制状态枚举
enum VXRecordingStatus { idle, recording, stopped, error }

/// 视频录制工具类
class VXVideoRecorderUtils {
  static final ImagePicker _imagePicker = ImagePicker();
  static VideoPlayerController? _videoController;
  static File? _currentVideoFile;
  static VXRecordingStatus _currentStatus = VXRecordingStatus.idle;

  /// 获取当前录制状态
  static VXRecordingStatus get currentStatus => _currentStatus;

  /// 获取当前视频文件
  static File? get currentVideoFile => _currentVideoFile;

  /// 检查并请求录制权限
  static Future<bool> requestPermissions(BuildContext context) async {
    bool isGranted = false;
    try {
      final results = await VXPermission.instance.requestMultipleWithDialog(
        context: context,
        permissions: [Permission.camera, Permission.microphone],
      );
      for (var entry in results.entries) {
        if (!entry.value) {
          isGranted = false;
          break;
        } else {
          isGranted = true;
        }
      }

      return isGranted;
    } catch (e) {
      throw Exception('权限请求失败: $e');
    }
  }

  /// 开始录制视频
  static Future<void> startRecording({
    required BuildContext context,
    Duration maxDuration = const Duration(minutes: 5),
    ImageSource source = ImageSource.camera,
  }) async {
    try {
      // 检查权限
      final hasPermissions = await requestPermissions(context);
      if (!hasPermissions) {
        _currentStatus = VXRecordingStatus.error;
        throw Exception('缺少必要的录制权限');
      }

      // 重置状态
      _currentStatus = VXRecordingStatus.recording;
      _currentVideoFile = null;

      // 开始录制
      final XFile? videoFile = await _imagePicker.pickVideo(
        source: source,
        maxDuration: maxDuration,
      );

      if (videoFile != null) {
        _currentVideoFile = File(videoFile.path);
        _currentStatus = VXRecordingStatus.stopped;
      } else {
        _currentStatus = VXRecordingStatus.idle;
      }
    } catch (e) {
      _currentStatus = VXRecordingStatus.error;
      throw Exception('开始录制失败: $e');
    }
  }

  /// 结束录制并保存视频
  static Future<File?> stopAndSaveRecording() async {
    try {
      if (_currentVideoFile != null && _currentVideoFile!.existsSync()) {
        _currentStatus = VXRecordingStatus.stopped;
        return _currentVideoFile;
      }
      return null;
    } catch (e) {
      _currentStatus = VXRecordingStatus.error;
      throw Exception('保存视频失败: $e');
    }
  }

  /// 取消录制并删除视频文件
  static Future<void> cancelAndDeleteRecording() async {
    try {
      if (_currentVideoFile != null && _currentVideoFile!.existsSync()) {
        await _currentVideoFile!.delete();
        _currentVideoFile = null;
      }
      _currentStatus = VXRecordingStatus.idle;
    } catch (e) {
      _currentStatus = VXRecordingStatus.error;
      throw Exception('删除视频失败: $e');
    }
  }

  /// 初始化视频预览控制器
  static Future<void> initializeVideoController() async {
    if (_currentVideoFile != null) {
      _videoController = VideoPlayerController.file(_currentVideoFile!);
      await _videoController!.initialize();
    }
  }

  /// 播放/暂停视频
  static void toggleVideoPlayback() {
    if (_videoController != null) {
      if (_videoController!.value.isPlaying) {
        _videoController!.pause();
      } else {
        _videoController!.play();
      }
    }
  }

  /// 构建视频预览组件
  static Widget buildVideoPreview() {
    if (_currentVideoFile == null) {
      return Container(
        width: 300,
        height: 200,
        color: Colors.grey[300],
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.videocam, size: 50, color: Colors.grey),
            SizedBox(height: 8),
            Text('暂无视频', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    if (_videoController == null || !_videoController!.value.isInitialized) {
      return Container(
        width: 300,
        height: 200,
        color: Colors.grey[200],
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return GestureDetector(
      onTap: toggleVideoPlayback,
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: _videoController!.value.aspectRatio,
            child: VideoPlayer(_videoController!),
          ),
          if (!_videoController!.value.isPlaying)
            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(Icons.play_arrow, size: 50, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  /// 获取视频信息
  static Future<Map<String, dynamic>> getVideoInfo() async {
    if (_currentVideoFile == null) {
      return {};
    }

    try {
      await initializeVideoController();
      final duration = _videoController!.value.duration;
      final fileSize = await _currentVideoFile!.length();

      return {
        'path': _currentVideoFile!.path,
        'duration': duration,
        'fileSize': fileSize,
        'fileName': _currentVideoFile!.path.split('/').last,
        'width': _videoController!.value.size.width,
        'height': _videoController!.value.size.height,
      };
    } catch (e) {
      throw Exception('获取视频信息失败: $e');
    }
  }

  /// 释放资源
  static void dispose() {
    _videoController?.dispose();
    _videoController = null;
  }
}
