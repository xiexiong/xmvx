import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xmvx/extension/vx_image_ext.dart';
import 'package:xmvx/helper/vx_color.dart';

class VxAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showDefaultBackButton;
  final Color? backgroundColor;
  final IconThemeData? iconTheme;
  final double elevation;

  // ignore: use_super_parameters
  const VxAppbarWidget({
    Key? key,
    required this.title,
    this.actions,
    this.showDefaultBackButton = true,
    this.backgroundColor,
    this.iconTheme,
    this.elevation = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(color: VxColor.c1A1A1A, fontSize: 36.sp, fontWeight: FontWeight.w600),
      ),
      leading:
          showDefaultBackButton
              ? GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: VxImageExt(assetPath: "assets/vx_back_icon.png", color: VxColor.c1A1A1A),
                ),
              )
              : null,
      automaticallyImplyLeading: false,
      actions: actions,
      backgroundColor: backgroundColor ?? Colors.transparent,
      iconTheme: iconTheme ?? Theme.of(context).iconTheme,
      elevation: elevation,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

//使用示例：
// 基础用法（带返回键+标题）
// Scaffold(
//   appBar: UniversalAppBar(title: '首页'),
// )

// // 隐藏返回键+自定义右侧菜单
// Scaffold(
//   appBar: UniversalAppBar(
//     title: '个人中心',
//     showDefaultBackButton: false,
//     actions: [
//       IconButton(icon: Icon(Icons.settings), onPressed: () {}),
//     ],
//   ),
// )

// // 完全自定义样式
// Scaffold(
//   appBar: UniversalAppBar(
//     title: '深色主题',
//     backgroundColor: Colors.black,
//     iconTheme: IconThemeData(color: Colors.white),
//     elevation: 0,
//   ),
// )
