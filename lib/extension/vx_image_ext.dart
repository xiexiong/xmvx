import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VxImageExt extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final BlendMode? colorBlendMode;

  // ignore: use_super_parameters
  const VxImageExt({
    Key? key,
    required this.assetPath,
    this.width,
    this.height,
    this.fit,
    this.color,
    this.colorBlendMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      width: width ?? 36.w,
      height: height ?? 36.w,
      fit: fit,
      color: color,
      colorBlendMode: colorBlendMode,
      package: "xmvx",
    );
  }
}
