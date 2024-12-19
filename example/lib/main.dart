import 'package:flutter/material.dart';
import 'dart:async';
import 'package:tiktok_integration/tiktok_integration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initializeTikTokSdk();
  }

  /// Initialize the TikTok SDK.
  Future<void> initializeTikTokSdk() async {
    try {
      // Replace these with your actual app IDs.
      const String appId = 'YOUR_APP_ID';
      const String ttAppId = 'YOUR_TIKTOK_APP_ID';

      await TiktokIntegration.initializeSdk(appId, ttAppId);
      debugPrint("TikTok SDK initialized successfully.");

      // Track an example event after initialization.
      await TiktokIntegration.trackEvent(
        'app_start',
        eventId: '12345',
        eventParams: {'source': 'flutter_example'},
      );
      debugPrint("Event tracked successfully.");
    } catch (e) {
      debugPrint("Error initializing TikTok SDK: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TikTok Integration Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  // Example of tracking a custom event when a button is pressed.
                  await TiktokIntegration.trackEvent(
                    'button_click',
                    eventParams: {'buttonName': 'TestButton'},
                  );
                  debugPrint("Button click event tracked.");
                },
                child: const Text('Track Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
