 
import 'package:ai_text_summrizer/utils/components/app_colors.dart';
import 'package:ai_text_summrizer/utils/components/app_images.dart';
import 'package:ai_text_summrizer/utils/fonts/app_fonts.dart';
import 'package:ai_text_summrizer/view_model/splash_controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    Get.find<SplashController>().loadSplashInterAd(context);
  }
  @override
  Widget build(BuildContext context) {
    // controller init

    return Scaffold(
      backgroundColor: Appcolor.splashBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.splashLogo, height: 100),
            const SizedBox(height: 10),
            Text(
              "Humanizer.AI",
              style: TextStyle(
                fontFamily: AppFonts.roboto,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
