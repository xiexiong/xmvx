import 'package:flutter/material.dart';

class VxColor {
  // 自身色值
  static const Color cWhite = Colors.white;
  static const Color cBlack = Colors.black;
  static const Color c1470FF = Color(0xFF1470FF);
  static const Color c1CAEFF = Color(0xFF1CAEFF);
  static const Color c1359FA = Color(0xFF1359FA);
  static const Color c34B3FF = Color(0xFF34B3FF);
  static const Color c0FCE8C = Color(0xFF0FCE8C);
  static const Color cFF4848 = Color(0xFFFF4848);
  static const Color c191C27 = Color(0xFF191C27);
  static const Color c5A6073 = Color(0xFF5A6073);
  static const Color c9EA5BB = Color(0xFF9EA5BB);
  static const Color cF6F7F8 = Color(0xFFF6F7F8);
  static const Color cE8EBF3 = Color(0xFFE8EBF3);

  static const Color c4F7EFF = Color(0xFF4F7EFF);
  static const Color c1A1A1A = Color(0xFF1A1A1A);
  static const Color c51565F = Color(0xFF51565F);
  static const Color c969DA7 = Color(0xFF969DA7);
  static const Color cEDEDED = Color(0xFFEDEDED);
  static const Color cF4F5FA = Color(0xFFF4F5FA);
  static const Color cD8EDFF = Color(0xFFD8EDFF);
  static const Color cE8F5FF = Color(0xFFE8F5FF);
  static const Color cFF3B30 = Color(0xFFFF3B30);
  static const Color c15D179 = Color(0xFF15D179);
  static const Color c232323 = Color(0xFF232323);
  static const Color c323232 = Color(0xFF323232);
  static const Color c143C42 = Color(0xFF143C42);
  static const Color cE3F0FD = Color(0xFFE3F0FD);

  // ignore: constant_identifier_names
  static const LinearGradient cD8EDFF_cF4F5FA = LinearGradient(
    colors: [cD8EDFF, cF4F5FA],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  // ignore: constant_identifier_names
  static const LinearGradient cE8F5FF_cWhite = LinearGradient(
    colors: [cE8F5FF, cWhite],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ignore: constant_identifier_names
  static const LinearGradient cE8F5FF_cE3F0FD = LinearGradient(
    colors: [cE8F5FF, cE3F0FD],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ignore: constant_identifier_names
  static const LinearGradient cE3F0FD_cF4F5FA = LinearGradient(
    colors: [cE3F0FD, cF4F5FA],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

/// 将颜色转换为字符串
String colorToString(Color color, {String defaultColor = 'FF000000'}) {
  try {
    return color.toString().split('(0x')[1].split(')')[0];
  } catch (e) {
    return defaultColor;
  }
}

/// 将字符串转换为颜色
// Color _hexColor(String hexString, {Color defaultColor = Colors.black}) {
//   try {
//     final buffer = StringBuffer();
//     if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
//     buffer.write(hexString.replaceFirst('#', ''));
//     return Color(int.parse(buffer.toString(), radix: 16));
//   } catch (e) {
//     return defaultColor;
//   }
// }
