import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xmvx/helper/vx_color.dart';

/// 通用自定义内容底部弹窗工具类
class VXAdaptiveBottomSheet extends StatelessWidget {
  final Widget left;
  final Widget center;
  final Widget right;
  final Widget child;
  final double? maxHeight;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final bool showDragHandle;
  final String? bottomTxt;
  final bool isShowButtom;

  const VXAdaptiveBottomSheet({
    super.key,
    required this.left,
    required this.center,
    required this.right,
    required this.child,
    this.maxHeight,
    this.backgroundColor,
    this.borderRadius,
    this.showDragHandle = false,
    this.bottomTxt,
    this.isShowButtom = true,
  });

  /// 静态方法：弹出底部弹窗
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget left,
    required Widget center,
    required Widget right,
    required Widget child,
    double? maxHeight,
    Color? backgroundColor,
    String? bottomTxt,
    bool isShowButtom = true,
    BorderRadius? borderRadius,
    bool showDragHandle = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder:
          (context) => VXAdaptiveBottomSheet(
            left: left,
            center: center,
            right: right,
            // ignore: sort_child_properties_last
            child: child,
            maxHeight: maxHeight,
            bottomTxt: bottomTxt,
            isShowButtom: isShowButtom,
            backgroundColor: backgroundColor,
            borderRadius: borderRadius,
            showDragHandle: showDragHandle,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxSheetHeight = maxHeight ?? constraints.maxHeight * 0.9;
        return Container(
          constraints: BoxConstraints(maxHeight: maxSheetHeight),
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: backgroundColor ?? Theme.of(context).dialogBackgroundColor,
            borderRadius: borderRadius ?? const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showDragHandle)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.w),
                  child: Container(
                    width: 64.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(4.w),
                    ),
                  ),
                ),
              // 顶部栏：左中右
              SizedBox(
                height: 96.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.w),
                  child: Row(
                    children: [
                      Expanded(child: left),
                      Expanded(child: Center(child: center)),
                      Expanded(child: Container(alignment: Alignment.centerRight, child: right)),
                    ],
                  ),
                ),
              ),
              // 内容区
              // Flexible(child: SingleChildScrollView(child: child)),
              Flexible(child: child),
              Visibility(visible: isShowButtom, child: _bottomButtonWidget(bottomTxt ?? "")),
            ],
          ),
        );
      },
    );
  }

  Widget _bottomButtonWidget(String txt) {
    return Container(
      height: 96.w,
      margin: EdgeInsets.only(top: 16.w, left: 30.w, right: 30.w, bottom: 58.w),
      decoration: BoxDecoration(color: VxColor.c4F7EFF, borderRadius: BorderRadius.circular(24.w)),
      child: Center(
        child: Text(
          txt,
          style: TextStyle(color: VxColor.cWhite, fontSize: 34.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
