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
    override fun createNativeAd(
        nativeAd: NativeAd,
        customOptions: MutableMap<String, Any>?
    ): NativeAdView {
        val adView = LayoutInflater.from(context)
            .inflate(R.layout.native_ads_modern, null) as NativeAdView

        // Media (big image/video for large ad)
        adView.mediaView = adView.findViewById<MediaView>(R.id.native_ad_media).apply {
            nativeAd.mediaContent?.let { setMediaContent(it) }
        }

        // Headline
        adView.headlineView = adView.findViewById<TextView>(R.id.native_ad_headline).apply {
            text = nativeAd.headline
        }

        // Body
        adView.bodyView = adView.findViewById<TextView>(R.id.native_ad_body).apply {
            text = nativeAd.body ?: ""
        }

        // Icon
        adView.iconView = adView.findViewById<ImageView>(R.id.native_ad_icon).apply {
            if (nativeAd.icon != null) {
                setImageDrawable(nativeAd.icon?.drawable)
                visibility = View.VISIBLE
            } else {
                visibility = View.GONE
            }
        }

        // Advertiser
        adView.advertiserView = adView.findViewById<TextView>(R.id.ad_advertiser).apply {
            text = nativeAd.advertiser ?: ""
        }

        // CTA Button
        adView.callToActionView = adView.findViewById<Button>(R.id.native_ad_button).apply {
            text = nativeAd.callToAction ?: "Open"
            visibility = if (nativeAd.callToAction == null) View.GONE else View.VISIBLE
        }

        adView.setNativeAd(nativeAd)
        return adView
    }
}
