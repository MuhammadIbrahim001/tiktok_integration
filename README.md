# TikTok Integration in Flutter

This guide demonstrates how to integrate the TikTok SDK in a Flutter application using the `tiktok_integration` package. Below are the steps to set up, configure, and use this integration.

---

## Prerequisites

1. **Flutter SDK** installed on your system. [Install Flutter](https://docs.flutter.dev/get-started/install)
2. A **TikTok Developer Account** to get your App ID and TikTok App ID. [TikTok Developers](https://developers.tiktok.com/)
3. Basic knowledge of Flutter development.

---

## Steps to Set Up the Project


### 1. Update `AndroidManifest.xml`
Add the following permission to your `AndroidManifest.xml` file:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
```

Ensure that the file has the correct structure:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.myapp">

    <uses-permission android:name="android.permission.INTERNET"/>

    <application
        android:label="@string/app_name"
        android:icon="@mipmap/ic_launcher"
        android:theme="@style/AppTheme">
        <!-- Other configurations -->
    </application>
</manifest>
```

---

### 2. Update `settings.gradle`
Add the following line to your `settings.gradle` file in the repositories section:

```gradle
maven { url 'https://www.jitpack.io' }
```
Example:

```gradle
pluginManagement {
    repositories {
        google()
        mavenCentral()
        maven { url 'https://www.jitpack.io' } // Add this line
    }
}

```

---

### 3. Update `build.gradle`
Add the following line to your project-level `build.gradle` file in the repositories section:
```gradle
maven { url 'https://www.jitpack.io' }

```
Example:

```gradle
allprojects {
    repositories {
        google()
        mavenCentral()
        maven { url 'https://www.jitpack.io' } // Add this line
    }
}

```

---

### 4. Initialize the TikTok SDK
In your Flutter project, create a Dart file (`main.dart`) and use the following example code to integrate and initialize the TikTok SDK:

```dart
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
      const String appId = 'YOUR_APP_ID';
      const String ttAppId = 'YOUR_TIKTOK_APP_ID';

      await TiktokIntegration.initializeSdk(appId, ttAppId);
      debugPrint("TikTok SDK initialized successfully.");

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
```

Replace `YOUR_APP_ID` and `YOUR_TIKTOK_APP_ID` with the actual IDs provided by TikTok.

---

## Testing the Integration

1. Run the app using:
   ```bash
   flutter run
   ```
2. Check the console logs to verify that the SDK is initialized and events are tracked successfully.
3. Test the button functionality to track custom events.

---

## Additional Notes

- Ensure you have a stable internet connection for downloading dependencies and testing SDK integration.
- If you encounter issues, check the logs for detailed error messages.

For more information, refer to the [TikTok Developers Documentation](https://developers.tiktok.com/).

