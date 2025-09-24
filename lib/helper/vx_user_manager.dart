/*
 * 文件名称: user_manager.dart
 * 创建时间: 2025/04/12 08:42:46
 * 作者名称: Andy.Zhao
 * 联系方式: smallsevenk@vip.qq.com
 * 创作版权: Copyright (c) 2025 XianHua Zhao (andy)
 * 功能描述:  
 */

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xmvx/helper/vx_global.dart';
import 'package:xmvx/repo/resp/vx_user_resp.dart';

class VXUserManager {
  static const String userInfokey = 'XMCSUserInfo';
  final CSUserResp _user = CSUserResp();
  static Map<String, dynamic>? threeLoginData;
  static final VXUserManager _instance = VXUserManager._internal();

  // 单例模式构造函数
  factory VXUserManager() => _instance;
  VXUserManager._internal();

  // 初始化方法
  initialize() {
    _loadFromCache();
  }

  SharedPreferences get prefs {
    return VXGlobal.prefs;
  }

  // 从缓存加载数据
  void _loadFromCache() {
    _user.userId = prefs.getInt('userId');
    _user.token = prefs.getString('token');
  }

  // 保存用户信息
  Future<void> saveUserInfo(CSUserResp user) async {
    if (user.userId == null || user.token == null) {
      debugPrint('用户信息不正确');
      return;
    }
    final jsonStr = jsonEncode(user.toJson());
    await prefs.setString(userInfokey, jsonStr);
  }

  void saveNewToken(CSUserResp userResp) {
    CSUserResp user = userInfo;
    user.token = userResp.token;
    user.needRefresh = false;
    user.refreshToken = userResp.refreshToken;
    saveUserInfo(user);
  }

  // 清除用户信息
  Future<void> clearUserInfo() async {
    await prefs.remove(userInfokey);
  }

  // 获取用户信息
  CSUserResp get userInfo {
    final userInfoJson = prefs.getString(userInfokey) ?? '{}';
    return CSUserResp.fromJson(jsonDecode(userInfoJson));
  }

  int get _userId {
    return userInfo.userId ?? -1;
  }

  static int get userId {
    return VXUserManager()._userId;
  }

  static String get userName {
    return VXUserManager().userInfo.nickname;
  }

  // 判断登录状态
  bool get isLogin {
    return userInfo.token != null && userInfo.token!.isNotEmpty;
  }
}
