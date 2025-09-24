/*
* 文件名称: base_resp.dart
* 创建时间: 2025/04/10 09:25:58
* 作者名称: Andy.Zhao
* 联系方式: smallsevenk@vip.qq.com
* 创作版权: Copyright (c) 2025 XianHua Zhao (andy)
*/

import 'package:xmvx/extension/vx_map_ext.dart';

class CSBaseResponse<T> {
  int code;
  String message;
  T? data;

  CSBaseResponse({required this.code, required this.message, this.data});

  factory CSBaseResponse.fromJson(Map<String, dynamic> json) {
    return CSBaseResponse(
      code: json.getInt('code'),
      message: json.getString('message'),
      data: json['data'],
    );
  }

  //   // 请求成功判断逻辑（兼容原 `isSuccess` 逻辑）
  bool get success => code == 200;

  bool get refreshToken => code == 100003;

  bool get refreshTokenFailed => code == 100008;
}

abstract class XMResp {
  XMResp();

  /// 转换对象为 JSON
  XMResp fromJson(Map<String, dynamic> json);

  /// 转换对象为 JSON
  Map<String, dynamic> toJson();
}
