/*
 * 文件名称: xmnetwork_image.dart
 * 创建时间: 2025/04/14 15:07:49
 * 作者名称: Andy.Zhao
 * 联系方式: smallsevenk@vip.qq.com
 * 创作版权: Copyright (c) 2025 XianHua Zhao (andy)
 * 功能描述:  
 */

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class VXNetworkImage extends StatelessWidget {
  final String imageUrl;
  final String? placeholderName;

  // CachedNetworkImage 的所有属性
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Alignment alignment;
  final Duration? fadeInDuration;
  final Curve fadeInCurve;
  final Duration? fadeOutDuration;
  final Curve fadeOutCurve;
  final ProgressIndicatorBuilder? progressIndicatorBuilder;
  final LoadingErrorWidgetBuilder? errorWidget;
  final PlaceholderWidgetBuilder? placeholder;
  final bool useOldImageOnUrlChange;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final Map<String, String>? httpHeaders;
  final Duration? cacheManagerTimeout;

  // ignore: use_super_parameters
  const VXNetworkImage({
    Key? key,
    required this.imageUrl,
    this.placeholderName,
    this.fit,
    this.width,
    this.height,
    this.alignment = Alignment.center,
    this.fadeInDuration,
    this.fadeInCurve = Curves.easeIn,
    this.fadeOutDuration,
    this.fadeOutCurve = Curves.easeOut,
    this.progressIndicatorBuilder,
    this.errorWidget,
    this.placeholder,
    this.useOldImageOnUrlChange = false,
    this.memCacheWidth,
    this.memCacheHeight,
    this.httpHeaders,
    this.cacheManagerTimeout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var placeholderImage = placeholderName ?? 'discover_list';
    var placeholder = Image.asset(
      'assets/placeholder/$placeholderImage.png',
      width: width,
      height: height,
      fit: fit,
    );
    if (imageUrl.isEmpty) {
      debugPrint('XMNetworkImage placeholder="$placeholderImage", context=${context.widget}');
      return placeholder;
    }
    // debugPrint('XMNetworkImage: 图片链接 $imageUrl');
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: width,
      height: height,
      alignment: alignment,
      fadeInDuration: fadeInDuration ?? const Duration(milliseconds: 300),
      fadeInCurve: fadeInCurve,
      fadeOutDuration: fadeOutDuration,
      fadeOutCurve: fadeOutCurve,
      progressIndicatorBuilder: progressIndicatorBuilder,
      placeholder: (context, url) => placeholder,
      errorWidget: (context, url, error) => placeholder,
      useOldImageOnUrlChange: useOldImageOnUrlChange,
      memCacheWidth: memCacheWidth,
      memCacheHeight: memCacheHeight,
      httpHeaders: httpHeaders,
    );
  }
}
