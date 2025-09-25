package com.ai.writing.tool.humanizer.summarizer.paraphraser

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.TextView
import com.google.android.gms.ads.nativead.MediaView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory

class NativeAdFactoryLarge(private val context: Context) : NativeAdFactory {
    override fun createNativeAd(nativeAd: NativeAd, customOptions: MutableMap<String, Any>?): NativeAdView {
        val adView = LayoutInflater.from(context).inflate(R.layout.native_ads_large, null) as NativeAdView

        adView.headlineView = adView.findViewById<TextView>(R.id.native_ad_headline).apply {
            text = nativeAd.headline
        }
        adView.bodyView = adView.findViewById<TextView>(R.id.native_ad_body).apply {
            text = nativeAd.body
        }
        adView.mediaView = adView.findViewById<MediaView>(R.id.native_ad_media).apply {
            setMediaContent(nativeAd.mediaContent)
        }
        adView.iconView = adView.findViewById<ImageView>(R.id.native_ad_icon).apply {
            setImageDrawable(nativeAd.icon?.drawable)
        }
        adView.advertiserView = adView.findViewById<TextView>(R.id.ad_advertiser).apply {
            text = nativeAd.advertiser
        }
        adView.callToActionView = adView.findViewById<Button>(R.id.native_ad_button).apply {
            text = nativeAd.callToAction
        }

        adView.setNativeAd(nativeAd)
        return adView
    }
}
