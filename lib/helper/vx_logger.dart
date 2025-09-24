/*
 * 文件名称: logger.dart
 * 创建时间: 2025/04/12 08:43:02
 * 作者名称: Andy.Zhao
 * 联系方式: smallsevenk@vip.qq.com
 * 创作版权: Copyright (c) 2025 XianHua Zhao (andy)
 * 功能描述:  
 */

import 'package:flutter/widgets.dart';
import 'package:xmvx/helper/vx_global.dart';

var key = 'xmlog';
Future<void> slog(String log) async {
  var p = VXGlobal.prefs;
  var logs = p.getStringList(key) ?? [];
  logs.add(DateTime.now().toIso8601String());
  logs.add(log);
  await p.setStringList(key, logs);
}

rlog() {
  VXGlobal.prefs.setStringList(key, []);
}

List<String> glog() {
  var p = VXGlobal.prefs;
  var logs = p.getStringList(key) ?? [];
  return logs;
}

dp(dynamic log, {int? wrapWidth}) {
  log = log is String ? log : log.toString();
  debugPrint(log, wrapWidth: wrapWidth);
}
