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
  final Color? barrierColor;
  final BorderRadius? borderRadius;
  final bool showDragHandle;
  final String? bottomTxt;
  final bool isShowButtom;
  final VoidCallback? onClose; // 新增关闭回调

  const VXAdaptiveBottomSheet({
    super.key,
    required this.left,
    required this.center,
    required this.right,
    required this.child,
    this.maxHeight,
    this.backgroundColor,
    this.barrierColor,
    this.borderRadius,
    this.showDragHandle = false,
    this.bottomTxt,
    this.isShowButtom = true,
    this.onClose, // 新增
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
    Color? barrierColor,
    String? bottomTxt,
    bool isShowButtom = true,
    BorderRadius? borderRadius,
    bool showDragHandle = true,
    VoidCallback? onClose, // 新增
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: barrierColor ?? Colors.black54,
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
            barrierColor: barrierColor,
            borderRadius: borderRadius,
            showDragHandle: showDragHandle,
            onClose: onClose, // 新增
          ),
    ).whenComplete(() {
      if (onClose != null) onClose();
    });
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
                Container(
                  width: 64.w,
                  height: 8.w,
                  margin: EdgeInsets.symmetric(vertical: 16.w),
                  decoration: BoxDecoration(
                    color: VxColor.c51565F,
                    borderRadius: BorderRadius.circular(4.w),
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
              Flexible(child: child),
              Visibility(
                visible: isShowButtom,
                child: _bottomButtonWidget(context, bottomTxt ?? ""),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _bottomButtonWidget(BuildContext context, String txt) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        if (onClose != null) onClose!(); // 关闭时回调
      },
      child: Container(
        height: 96.w,
        margin: EdgeInsets.only(top: 16.w, left: 30.w, right: 30.w, bottom: 58.w),
        decoration: BoxDecoration(
          color: VxColor.c4F7EFF,
          borderRadius: BorderRadius.circular(24.w),
        ),
        child: Center(
          child: Text(
            txt,
            style: TextStyle(color: VxColor.cWhite, fontSize: 34.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
