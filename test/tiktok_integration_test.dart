import 'package:flutter_test/flutter_test.dart';
import 'package:tiktok_integration/tiktok_integration.dart';
import 'package:tiktok_integration/tiktok_integration_platform_interface.dart';
import 'package:tiktok_integration/tiktok_integration_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTiktokIntegrationPlatform
    with MockPlatformInterfaceMixin
    implements TiktokIntegrationPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TiktokIntegrationPlatform initialPlatform =
      TiktokIntegrationPlatform.instance;

  test('$MethodChannelTiktokIntegration is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTiktokIntegration>());
  });

  test('getPlatformVersion', () async {
    TiktokIntegration tiktokIntegrationPlugin = TiktokIntegration();
    MockTiktokIntegrationPlatform fakePlatform =
        MockTiktokIntegrationPlatform();
    TiktokIntegrationPlatform.instance = fakePlatform;

    // expect(await tiktokIntegrationPlugin.getPlatformVersion(), '42');
  });
}
