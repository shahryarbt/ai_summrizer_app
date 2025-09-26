import 'dart:async';
import 'dart:developer';
import 'package:ai_text_summrizer/services/adManager.dart';
import 'package:ai_text_summrizer/services/remote_config_service.dart';
import 'package:ai_text_summrizer/view/language_view/language_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  Timer? _splashTimer;
  bool _navigated = false; // ensure ek hi dafa navigate ho

  void loadSplashInterAd(BuildContext context) async {
    log('fn starts');

    // 2 sec splash delay
    Future.delayed(const Duration(seconds: 2), () {
      try {
        if (RemoteConfigService().intersitialModel.splashIntersitial) {
          log('splash enabled from remote config ');
          AdManager.loadInterstitialAd(
            onAdLoaded: () {
              if (_navigated) {
                // agar already navigate ho gaya to ad ignore kar do
                AdManager.disposeInterstitial();
                return;
              }
              log('✅ Interstitial Loaded in Splash');
              _showAd();
            },
            onAdFailedToLoad: (error) {
              log('❌ Interstitial failed to load: $error');
              _goNext();
            },
            context: context,
          );
        } else {
          log('splash disable from remote config');
          _goNext();
        }
      } catch (e) {
        log('❌ Exception in loadSplashInterAd: $e');
        _goNext();
      }
    });

    // ✅ Hard timeout
    _splashTimer = Timer(const Duration(seconds: 7), () {
      if (!_navigated) {
        log('⏰ Timeout reached → navigating');
        _goNext();
      }
    });
  }

  void _showAd() {
    AdManager.showInterstitialAd(
      onDismiss: () {
        log('🚪 Ad dismissed → next screen');
        _goNext();
      },
      onAddFailedToShow: () {
        log('❌ Failed to show Ad → next screen');
        _goNext();
      },
    );
  }

  void _goNext() {
    if (_navigated) return;
    _navigated = true;

    _splashTimer?.cancel();
    AdManager.disposeInterstitial(); // ✅ ensure ad cancel/dispose

    Get.off(() => LanguageSelectionScreen());
  }

  @override
  void onClose() {
    _splashTimer?.cancel();
    AdManager.disposeInterstitial(); // ✅ cleanup on destroy
    super.onClose();
  }
}
