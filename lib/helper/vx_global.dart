/*
 * 文件名称: global.dart
 * 创建时间: 2025/04/12 08:43:26
 * 作者名称: Andy.Zhao
 * 联系方式: smallsevenk@vip.qq.com
 * 创作版权: Copyright (c) 2025 XianHua Zhao (andy)
 * 功能描述:  
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xmvx/helper/vx_loading.dart';

class VXGlobal {
  // 单例模式
  static final VXGlobal _instance = VXGlobal._internal();
  factory VXGlobal() => _instance;
  VXGlobal._internal();

  /// SharedPreferences 实例
  static SharedPreferences? _prefs;

  /// 初始化全局属性
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();

    // 数据库连接
    // _db = await DataBaseManager.openDataBase();
  }

  /// 获取 SharedPreferences 实例
  static SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception("Global.init() must be called before accessing prefs.");
    }
    return _prefs!;
  }

  /// 全局主题模式
  static String get themeMode => prefs.getString('themeMode') ?? 'system';
  static set themeMode(String mode) {
    prefs.setString('themeMode', mode);
  }

  /// 全局语言设置
  static String get language => prefs.getString('language') ?? 'en';
  static set language(String lang) {
    prefs.setString('language', lang);
  }

  // static bool get autoPlaySwitchIsOpen {
  //   return CSGlobal.prefs.getBool(CSNuiUtil.autoPlayKey) ?? true;
  // }

  // static setAutoPlay() {
  //   CSGlobal.prefs.setBool(CSNuiUtil.autoPlayKey, !autoPlaySwitchIsOpen);
  // }
}

xmKeyboradHide() {
  SystemChannels.textInput.invokeMethod('TextInput.hide');
}

safeAreaBottomPadding(BuildContext context) {
  MediaQuery.of(context).padding.bottom;
}

VXLoading? csLoading;

Function(String? content, {int? animationTime, Object? stackTrace})? showCsToast;
Function()? csBackToNative;

void showToast(String? content, {int? animationTime, Object? stackTrace}) {
  showCsToast?.call(content, animationTime: animationTime, stackTrace: stackTrace);
}
