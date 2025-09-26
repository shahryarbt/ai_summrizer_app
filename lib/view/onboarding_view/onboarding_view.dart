import 'dart:developer';

import 'package:ai_text_summrizer/services/adManager.dart';
import 'package:ai_text_summrizer/services/remote_config_service.dart';
import 'package:ai_text_summrizer/utils/components/app_colors.dart';
import 'package:ai_text_summrizer/utils/components/app_images.dart';
import 'package:ai_text_summrizer/utils/components/response_config.dart';
import 'package:ai_text_summrizer/utils/fonts/app_fonts.dart';
import 'package:ai_text_summrizer/view/bottom_bar_view/bottom_bar_view.dart';
import 'package:ai_text_summrizer/view/home_view/dummy.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, String>> onboardingData = [
    {
      "title": "Smart Summarizer",
      "subtitle": "Turn long text into short, clear summaries",
      "aiText":
          "Nature is often described in plain words—trees, rivers, skies—but without emotion, it feels incomplete.",
      "image": AppImages.onb1,
    },
    {
      "title": "Rewrite Smarter",
      "subtitle": " Reframe your text with fresh, natural wording",
      "aiText":
          "AI responses are correct but often flat and lacking personality.",
      "image": AppImages.onb2,
    },
    {
      "title": "Make it Human",
      "subtitle": "Transform AI text into human-like content",
      "aiText": "AI content can sound mechanical, repetitive, or emotionless.",
      "image": AppImages.onb3,
    },
  ];

  @override
  void initState() {
    super.initState();

    AdManager.loadBannerAd(context: context);

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    // start fade-in as soon as screen loads
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void nextPage() {
    if (currentIndex < onboardingData.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      Get.offAll(() => BottomBarView());
      // TODO: Navigate to home screen after last page
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // color: Colors.amber,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: FadeTransition(
                    key: ValueKey<int>(currentIndex),
                    opacity:
                        currentIndex == 0
                            ? _fadeAnimation
                            : kAlwaysCompleteAnimation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        // vertical: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: SizeConfig.h(20)),
                          Text(
                            onboardingData[currentIndex]["title"]!,
                            style: TextStyle(
                              fontSize: SizeConfig.sp(22),
                              fontFamily: AppFonts.roboto,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              onboardingData[currentIndex]["subtitle"]!,
                              style: TextStyle(
                                fontSize: SizeConfig.sp(16),
                                fontFamily: AppFonts.roboto,
                                color: const Color(0xff1E1E1E),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: SizeConfig.h(10)),
                          Image.asset(
                            onboardingData[currentIndex]["image"]!,
                            height: SizeConfig.h(350),
                            fit: BoxFit.cover,
                            // width: double.infinity,
                          ),
                          // const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.h(10)),
              // Text('data'),
              // Spacer(),
              // Text('data'),
              // Indicator + Next
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: List.generate(
                          onboardingData.length,
                          (dotIndex) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            height: 6,
                            width: currentIndex == dotIndex ? 18 : 6,
                            decoration: BoxDecoration(
                              color:
                                  currentIndex == dotIndex
                                      ? Colors.black
                                      : Colors.grey[400],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: nextPage,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Appcolor.themeColor.withOpacity(0.1),
                        ),
                        child: Center(
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontFamily: AppFonts.roboto,
                              color: Appcolor.themeColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // const SizedBox(height: 20),
              RemoteConfigService().onboarding_native_OR_banner == 0
                  ? AdManager.getBannerWidget()
                  : Container(
                    height: 240,
                    // height: SizeConfig,
                    color: Colors.grey[300],
                    width: double.infinity,
                    // alignment: Alignment.center,
                    child: NativeAdWidget(),
                  ),
              // Ad space
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   // height: Get.height * 0.2,
      //   color: Colors.grey[300],
      //   width: double.infinity,
      //   // alignment: Alignment.center,
      //   child: Image.asset( AppImages.nativeAd, fit: BoxFit.cover),
      // ),
    );
  }
}
