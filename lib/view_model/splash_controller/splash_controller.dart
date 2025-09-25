import 'dart:async';
import 'dart:developer';
import 'package:ai_text_summrizer/services/adManager.dart';
import 'package:ai_text_summrizer/view/language_view/language_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  Timer? _timeoutTimer;

  @override
  void onInit() {
    super.onInit();
  }

  void loadSplashInterAd(BuildContext context) async {
    // 2 sec delay ke baad load karo
    Future.delayed(const Duration(seconds: 2), () {
      AdManager.loadInterstitialAd(
        onAdLoaded: () {
          log('✅ Interstitial Loaded in Splash');
          _showAd();
        },
        onAdFailedToLoad: (error) {
          log('❌ Interstitial failed to load: $error');
          _goNext();
        },
        context: context,
      );
    });
  }

  void _showAd() {
    bool adShown = false;

    // Timeout guard (3 sec)
    _timeoutTimer = Timer(const Duration(seconds: 3), () {
      if (!adShown) {
        log("⚠ Ad did not render in time → moving to next screen");
        _goNext();
      }
    });

    AdManager.showInterstitialAd(
      onDismiss: () {
        adShown = true;
        _timeoutTimer?.cancel();
        log('🚪 Ad dismissed → next screen');
        _goNext();
      },
      onAddFailedToShow: () {
        adShown = true;
        _timeoutTimer?.cancel();
        log('❌ Failed to show Ad → next screen');
        _goNext();
      },
    );
  }

  void _goNext() {
    _timeoutTimer?.cancel();
    Get.off(() => LanguageSelectionScreen());
  }
}
