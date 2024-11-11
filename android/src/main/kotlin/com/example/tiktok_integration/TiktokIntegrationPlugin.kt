package com.example.tiktok_integration

import android.content.Context
import androidx.annotation.NonNull
import com.tiktok.TikTokBusinessSdk

import org.json.JSONObject
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** TiktokIntegrationPlugin */
class TiktokIntegrationPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "tiktok_integration")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "initializeSdk" -> initializeSdk(call, result)
      "trackEvent" -> trackEvent(call, result)
      else -> result.notImplemented()
    }
  }

  private fun initializeSdk(call: MethodCall, result: Result) {
    val appId = call.argument<String>("appId")
    val ttAppId = call.argument<String>("ttAppId")
    if (appId != null && ttAppId != null) {
      val ttConfig = TikTokBusinessSdk.TTConfig(context)
        .setAppId(appId)
        .setTTAppId(ttAppId)

      TikTokBusinessSdk.initializeSdk(ttConfig)
      result.success("TikTok SDK initialized successfully")
    } else {
      result.error("INVALID_ARGUMENT", "App ID and TT App ID are required", null)
    }
  }

  private fun trackEvent(call: MethodCall, result: Result) {
    val eventName = call.argument<String>("eventName")
    val eventId = call.argument<String>("eventId")
    val eventParams = call.argument<Map<String, Any>>("eventParams")

    if (eventName != null) {
      if (eventId != null) {
        // Use the first trackEvent signature
        TikTokBusinessSdk.trackEvent(eventName, eventId)
        result.success("Event $eventName with ID $eventId tracked successfully")
      } else if (eventParams != null) {
        // Use the second trackEvent signature with JSONObject
        val jsonObject = JSONObject(eventParams)
        TikTokBusinessSdk.trackEvent(eventName, jsonObject)
        result.success("Event $eventName with parameters tracked successfully")
      } else {
        result.error("INVALID_ARGUMENT", "Either eventId or eventParams is required", null)
      }
    } else {
      result.error("INVALID_ARGUMENT", "Event name is required", null)
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
