import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xmvx/extension/vx_image_ext.dart';
import 'package:xmvx/helper/vx_color.dart';

class VXModuleStyleDetailPage extends StatefulWidget {
  const VXModuleStyleDetailPage({super.key});

  @override
  State<VXModuleStyleDetailPage> createState() => _ModuleStyleDetailPageState();
}

class _ModuleStyleDetailPageState extends State<VXModuleStyleDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VxColor.c1A1A1A,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // 背景内容
          Positioned.fill(
            child: Container(margin: EdgeInsets.only(bottom: 156.w), color: Colors.red),
          ),
          // 返回按钮
          Positioned(
            top: 108.w,
            left: 30.w,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: VxImageExt(
                assetPath: "assets/vx_back_icon.png",
                width: 48.w,
                height: 48.w,
                color: VxColor.cWhite,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        width: ScreenUtil().screenWidth,
        height: 96.w,
        margin: EdgeInsets.only(left: 60.w),
        decoration: BoxDecoration(
          color: VxColor.c4F7EFF,
          borderRadius: BorderRadius.circular(24.w),
        ),
        child: Center(
          child: Text(
            "做同款",
            style: TextStyle(color: VxColor.cWhite, fontSize: 34.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
