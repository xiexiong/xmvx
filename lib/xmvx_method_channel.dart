import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// An implementation of [XmvxPlatform] that uses method channels.
class MethodChannelXmvx {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('xmvx');
}
