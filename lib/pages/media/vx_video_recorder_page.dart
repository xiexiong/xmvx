import 'package:flutter/material.dart';
import 'package:xmvx/utils/vx_video_recorder_util.dart';

class VxVideoRecorderPage extends StatefulWidget {
  const VxVideoRecorderPage({super.key});

  @override
  State<VxVideoRecorderPage> createState() => _VxVideoRecorderPageState();
}

class _VxVideoRecorderPageState extends State<VxVideoRecorderPage> {
  bool _isLoading = false;
  String _statusMessage = '准备就绪';
  Map<String, dynamic> _videoInfo = {};

  @override
  void initState() {
    super.initState();
    _checkInitialStatus();
  }

  /// 检查初始状态
  void _checkInitialStatus() async {
    final hasPermissions = await VXVideoRecorderUtils.requestPermissions(context);
    setState(() {
      _statusMessage = hasPermissions ? '权限已授权' : '请授权必要权限';
    });
  }

  /// 开始录制视频
  Future<void> _startRecording() async {
    setState(() {
      _isLoading = true;
      _statusMessage = '正在启动摄像头...';
    });

    try {
      await VXVideoRecorderUtils.startRecording(
        context: context,
        maxDuration: const Duration(minutes: 2),
      );

      if (VXVideoRecorderUtils.currentVideoFile != null) {
        await VXVideoRecorderUtils.initializeVideoController();
        _videoInfo = await VXVideoRecorderUtils.getVideoInfo();

        setState(() {
          _statusMessage = '视频录制完成！';
        });
      } else {
        setState(() {
          _statusMessage = '录制已取消';
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = '录制失败: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 保存视频
  Future<void> _saveVideo() async {
    try {
      final savedFile = await VXVideoRecorderUtils.stopAndSaveRecording();
      if (savedFile != null) {
        setState(() {
          _statusMessage = '视频已保存至: ${savedFile.path}';
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = '保存失败: $e';
      });
    }
  }

  /// 取消录制
  Future<void> _cancelRecording() async {
    try {
      await VXVideoRecorderUtils.cancelAndDeleteRecording();
      setState(() {
        _statusMessage = '录制已取消，视频文件已删除';
        _videoInfo = {};
      });
    } catch (e) {
      setState(() {
        _statusMessage = '取消录制失败: $e';
      });
    }
  }

  /// 格式化文件大小
  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1048576) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / 1048576).toStringAsFixed(1)} MB';
  }

  /// 格式化时长
  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter视频录制工具'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 状态显示区域
            _buildStatusCard(),

            const SizedBox(height: 20),

            // 视频预览区域
            Center(child: VXVideoRecorderUtils.buildVideoPreview()),

            const SizedBox(height: 20),

            // 视频信息显示
            if (_videoInfo.isNotEmpty) _buildVideoInfoCard(),

            const SizedBox(height: 30),

            // 控制按钮区域
            _buildControlButtons(),
          ],
        ),
      ),
    );
  }

  /// 构建状态卡片
  Widget _buildStatusCard() {
    Color statusColor = Colors.blue;
    IconData statusIcon = Icons.info;

    switch (VXVideoRecorderUtils.currentStatus) {
      case VXRecordingStatus.recording:
        statusColor = Colors.orange;
        statusIcon = Icons.videocam;
      case VXRecordingStatus.stopped:
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
      case VXRecordingStatus.error:
        statusColor = Colors.red;
        statusIcon = Icons.error;
      case VXRecordingStatus.idle:
        statusColor = Colors.blue;
        statusIcon = Icons.info;
    }

    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(statusIcon, color: statusColor),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _statusMessage,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '当前状态: ${_getStatusText(VXVideoRecorderUtils.currentStatus)}',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建视频信息卡片
  Widget _buildVideoInfoCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('视频信息', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('文件名: ${_videoInfo['fileName']}'),
            Text('时长: ${_formatDuration(_videoInfo['duration'])}'),
            Text('大小: ${_formatFileSize(_videoInfo['fileSize'])}'),
            if (_videoInfo['width'] != null)
              Text('分辨率: ${_videoInfo['width']}x${_videoInfo['height']}'),
          ],
        ),
      ),
    );
  }

  /// 构建控制按钮
  Widget _buildControlButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // 开始录制按钮
        ElevatedButton.icon(
          onPressed:
              _isLoading || VXVideoRecorderUtils.currentStatus == VXRecordingStatus.recording
                  ? null
                  : _startRecording,
          icon: const Icon(Icons.videocam),
          label: const Text('开始录制'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),

        // 保存按钮
        ElevatedButton.icon(
          onPressed:
              VXVideoRecorderUtils.currentStatus != VXRecordingStatus.stopped ? null : _saveVideo,
          icon: const Icon(Icons.save),
          label: const Text('保存'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
        // 取消按钮
        ElevatedButton.icon(
          onPressed:
              VXVideoRecorderUtils.currentStatus != VXRecordingStatus.stopped
                  ? null
                  : _cancelRecording,
          icon: const Icon(Icons.cancel),
          label: const Text('取消'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
      ],
    );
  }

  /// 获取状态文本
  String _getStatusText(VXRecordingStatus status) {
    switch (status) {
      case VXRecordingStatus.idle:
        return '待机';
      case VXRecordingStatus.recording:
        return '录制中';
      case VXRecordingStatus.stopped:
        return '录制完成';
      case VXRecordingStatus.error:
        return '错误';
    }
  }

  @override
  void dispose() {
    VXVideoRecorderUtils.dispose();
    super.dispose();
  }
}
