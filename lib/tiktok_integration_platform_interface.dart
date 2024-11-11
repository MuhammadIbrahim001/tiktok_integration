import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'tiktok_integration_method_channel.dart';

abstract class TiktokIntegrationPlatform extends PlatformInterface {
  /// Constructs a TiktokIntegrationPlatform.
  TiktokIntegrationPlatform() : super(token: _token);

  static final Object _token = Object();

  static TiktokIntegrationPlatform _instance = MethodChannelTiktokIntegration();

  /// The default instance of [TiktokIntegrationPlatform] to use.
  ///
  /// Defaults to [MethodChannelTiktokIntegration].
  static TiktokIntegrationPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TiktokIntegrationPlatform] when
  /// they register themselves.
  static set instance(TiktokIntegrationPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
