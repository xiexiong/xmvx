import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:xmvx/utils/vx_sound_record_util.dart';

class VxRecordScreenState extends StatefulWidget {
  const VxRecordScreenState({super.key});

  @override
  State<VxRecordScreenState> createState() => _VxRecordScreenStateState();
}

class _VxRecordScreenStateState extends State<VxRecordScreenState> {
  final VxSoundRecorderUtil _recorderUtil = VxSoundRecorderUtil();

  @override
  void initState() {
    super.initState();
    // 预初始化录音器
    _recorderUtil.preInitialize(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("录音页面")),
      body: Padding(
        padding: EdgeInsetsGeometry.only(left: 100.w),
        child: Column(
          children: [
            Gap(60.w),
            GestureDetector(
              onTap: () async {
                // 开始录音
                final success = await _recorderUtil.startRecord(context);
                if (success) {
                  print('录音开始');
                } else {
                  print('录音启动失败');
                }
              },
              child: Text("开始录制"),
            ),
            Gap(60.w),
            GestureDetector(
              onTap: () async {
                await _recorderUtil.cancelRecord();
              },
              child: Text("取消录制"),
            ),
            Gap(60.w),
            GestureDetector(
              onTap: () async {
                // 停止录音
                final filePath = await _recorderUtil.stopAndSave();
                if (filePath != null) {
                  print('录音已保存到: $filePath');
                } else {
                  print('录音保存失败');
                }
              },
              child: Text("保存视频"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _recorderUtil.dispose();
  }
}
