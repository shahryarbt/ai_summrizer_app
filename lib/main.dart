import 'package:ai_text_summrizer/utils/components/response_config.dart';
import 'package:ai_text_summrizer/view/splash_view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:device_preview/device_preview.dart";

void main() {
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
