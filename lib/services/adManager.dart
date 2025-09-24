import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsManager {
  static BannerAd? _bannerAd;
  static InterstitialAd? _interstitialAd;

  // /// Initialize Ads SDK (call in main.dart before runApp)
  // static Future<void> initialize() async {
  //   await MobileAds.instance.initialize();
  // }
  static NativeAd? _nativeAd;
  static bool isNativeAdReady = false;

  static void loadNativeAd({
    required VoidCallback onAdLoaded,
    required VoidCallback onAdFailed,
  }) {
    _nativeAd = NativeAd(
      adUnitId: 'ca-app-pub-3940256099942544/2247696110', // ✅ Test Native Ad ID
      factoryId: 'adFactoryExample', // UI define karna padega (NativeAdFactory)
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          debugPrint("✅ Native Ad Loaded");
          isNativeAdReady = true;
          onAdLoaded();
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint("❌ Native Ad Failed: $error");
          ad.dispose();
          _nativeAd = null;
          isNativeAdReady = false;
          onAdFailed();
        },
      ),
    )..load();
  }

  static Widget getNativeAdWidget() {
    if (_nativeAd == null || !isNativeAdReady) {
      return const SizedBox();
    }
    return Container(
      height: 120,
      alignment: Alignment.center,
      child: AdWidget(ad: _nativeAd!),
    );
  }

  static void disposeNative() {
    _nativeAd?.dispose();
    _nativeAd = null;
    isNativeAdReady = false;
  }
  // ------------------- BANNER -------------------

  static void loadBannerAd({
    required VoidCallback onAdLoaded,
    required VoidCallback onAdFailed,
  }) {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111', // ✅ Test Banner ID
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint("✅ Banner Ad Loaded");
          onAdLoaded();
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint("❌ Banner Failed: $error");
          ad.dispose();
          _bannerAd = null;
          onAdFailed();
        },
      ),
    )..load();
  }

  static Widget getBannerAdWidget() {
    if (_bannerAd == null) return const SizedBox();
    return Container(
      alignment: Alignment.center,
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }

  static void disposeBanner() {
    _bannerAd?.dispose();
    _bannerAd = null;
  }

  // ------------------- INTERSTITIAL -------------------

  static void loadInterstitialAd({
    required VoidCallback onAdLoaded,
    required VoidCallback onAdFailed,
  }) {
    InterstitialAd.load(
      adUnitId:
          'ca-app-pub-3940256099942544/1033173712', // ✅ Test Interstitial ID
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint("✅ Interstitial Ad Loaded");
          _interstitialAd = ad;
          onAdLoaded();
        },
        onAdFailedToLoad: (error) {
          debugPrint("❌ Interstitial Failed: $error");
          _interstitialAd = null;
          onAdFailed();
        },
      ),
    );
  }

  static void showInterstitialAd({required VoidCallback onAdDismissed}) {
    if (_interstitialAd == null) {
      debugPrint("⚠️ Interstitial not ready");
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        debugPrint("👋 Interstitial Dismissed");
        ad.dispose();
        _interstitialAd = null;
        onAdDismissed();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        debugPrint("❌ Failed to show Interstitial: $error");
        ad.dispose();
        _interstitialAd = null;
        onAdDismissed();
      },
    );
    _interstitialAd!.show();
  }
}
