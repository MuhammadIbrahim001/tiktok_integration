import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'tiktok_integration_platform_interface.dart';

/// An implementation of [TiktokIntegrationPlatform] that uses method channels.
class MethodChannelTiktokIntegration extends TiktokIntegrationPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('tiktok_integration');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
