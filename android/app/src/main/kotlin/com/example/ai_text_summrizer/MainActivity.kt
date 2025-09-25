package com.ai.writing.tool.humanizer.summarizer.paraphraser
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine,
            "listTileMedium",
            NativeAdFactoryMedium(this)
        )
        GoogleMobileAdsPlugin.registerNativeAdFactory(
    flutterEngine,
    "listTileLarge",
    NativeAdFactoryLarge(this)
)

    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTileMedium")
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "listTileLarge")

    }
}
