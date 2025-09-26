import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';

class NativeAdWidget extends StatefulWidget {
  const NativeAdWidget({Key? key}) : super(key: key);

  @override
  State<NativeAdWidget> createState() => _NativeAdWidgetState();
}

class _NativeAdWidgetState extends State<NativeAdWidget> {
  NativeAd? _nativeAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {  
    _nativeAd = NativeAd(
      adUnitId: 'ca-app-pub-3940256099942544/2247696110', // ✅ Test Native Ad ID
      factoryId: 'listTileLarge', // ✅ same as MainActivity.kt
      // factoryId: 'listTileMedium', // ✅ same as MainActivity.kt
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('Failed to load native ad: $error');
        },
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoaded
        ? Container(
          // color: Colors.white,
          // height: 100,
          height: 234,
          width: double.infinity,
          alignment: Alignment.center,
          child: AdWidget(ad: _nativeAd!),
        )
        : const SizedBox.shrink();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }
}
