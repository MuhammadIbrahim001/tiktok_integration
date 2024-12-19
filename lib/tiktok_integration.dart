
import 'package:flutter/services.dart';

class TiktokIntegration {
  static const MethodChannel _channel = MethodChannel('tiktok_integration');

   /// Initializes the TikTok SDK with the provided [appId] and [ttAppId].
   static Future<void> initializeSdk(String appId, String ttAppId) async {
    try {
      await _channel.invokeMethod('initializeSdk', {
        'appId': appId,
        'ttAppId': ttAppId,
      });
    } on PlatformException catch (e) {
      print("Error initializing TikTok SDK: ${e.message}");
    }
  }

  static Future<void> trackEvent(String eventName, {String? eventId, Map<String, dynamic>? eventParams}) async {
    try {
      if (eventId != null) {
        await _channel.invokeMethod('trackEvent', {
          'eventName': eventName,
          'eventId': eventId,
        });
      } else if (eventParams != null) {
        await _channel.invokeMethod('trackEvent', {
          'eventName': eventName,
          'eventParams': eventParams,
        });
      }
    } on PlatformException catch (e) {
      print("Error tracking event: ${e.message}");
    }
  }
}
