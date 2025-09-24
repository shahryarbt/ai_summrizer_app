package com.ai.writing.tool.humanizer.summarizer.paraphraser
 

import android.content.Context
import android.widget.TextView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class NativeAdFactoryExample(private val context: Context) :
    GoogleMobileAdsPlugin.NativeAdFactory {

    override fun createNativeAd(
        nativeAd: NativeAd,
        customOptions: MutableMap<String, Any>?
    ): NativeAdView {
        // ✅ NativeAdView banana zaroori hai
        val adView = NativeAdView(context)

        // sirf ek simple TextView headline ke liye
        val textView = TextView(context)
        textView.text = nativeAd.headline

        // NativeAdView me child add karo
        adView.addView(textView)

        // adView ko nativeAd attach karo
        adView.setNativeAd(nativeAd)

        return adView
    }
}
