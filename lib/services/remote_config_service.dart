import 'dart:convert';

import 'package:ai_text_summrizer/model/intersitial_model.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  static final RemoteConfigService _instance = RemoteConfigService._internal();
  factory RemoteConfigService() => _instance;
  RemoteConfigService._internal();

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  /// initialize karna hoga app start mai
  Future<void> init() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 5), // testing
      ),
    );

    await _remoteConfig.fetchAndActivate();
  }

  // ✅ Yahan apke console ke parameter key likho
  // String get welcomeText => _remoteConfig.getString('welcome_text');
  int get onboarding_native_OR_banner =>
      _remoteConfig.getInt('onboarding_native_OR_banner');
  int get home_screen_ad_native_Or_banner =>
      _remoteConfig.getInt('home_screen_ad_native_Or_banner');
  int get input_screen_native_OR_banner =>
      _remoteConfig.getInt('input_screen_native_OR_banner');

  /// ✅ JSON ko parse karke model return karega
  IntersitialModel get intersitialModel {
    final jsonString = _remoteConfig.getString(
      'intersitial_ads',
    ); // console key
    // if (jsonString==false) {
    //   return IntersitialModel.empty(); // default values
    // }
    return IntersitialModel.fromJson(json.decode(jsonString));
  }
}
