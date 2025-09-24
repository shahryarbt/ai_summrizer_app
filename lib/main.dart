import 'package:ai_text_summrizer/utils/components/response_config.dart';
import 'package:ai_text_summrizer/view/splash_view/splash_view.dart';
import 'package:ai_text_summrizer/view_model/home_controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:device_preview/device_preview.dart";

import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'firebase_options.dart';

void main() async {
  // ...

  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  Get.put(HomeController());
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return GetMaterialApp(title: 'Flutter Demo', home: SplashView());
  }
}
