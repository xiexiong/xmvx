import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:xmvx/helper/vx_color.dart';

class VxBottomSheetWidget {
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget content,
    double? height,
    required VoidCallback onConfirm,
    VoidCallback? onDismiss,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      isDismissible: true,
      enableDrag: false,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            Navigator.pop(context);
            onDismiss?.call();
          },
          child: Container(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: () {},
              child: DraggableScrollableSheet(
                initialChildSize:
                    height != null
                        ? (height / MediaQuery.of(context).size.height).clamp(0.1, 0.9)
                        : 0.5,
                minChildSize: 0.3,
                maxChildSize: 0.9,
                builder: (_, controller) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: VxColor.c232323,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    child: Column(
                      children: [
                        Gap(16.w),
                        Center(
                          child: Container(
                            width: 64.w,
                            height: 8.w,
                            decoration: BoxDecoration(
                              color: VxColor.c51565F,
                              borderRadius: BorderRadius.circular(4.w),
                            ),
                          ),
                        ),
                        Gap(16.w),
                        // 标题栏
                        SizedBox(
                          height: 80.w,
                          child: Row(
                            children: [
                              SizedBox(width: 95.w),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    title,
                                    style: TextStyle(
                                      fontSize: 32.sp,
                                      fontWeight: FontWeight.w500,
                                      color: VxColor.cWhite,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.check, weight: 48.w, color: VxColor.cWhite),
                                onPressed: () {
                                  Navigator.pop(context);
                                  onConfirm();
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: ScreenUtil().screenWidth,
                          height: 1.w,
                          color: VxColor.c323232,
                        ),
                        // 横向滚动区域
                        content,
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
