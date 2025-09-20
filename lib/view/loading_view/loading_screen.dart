import 'dart:async';
import 'dart:developer';
import 'package:ai_text_summrizer/utils/components/app_colors.dart';
import 'package:ai_text_summrizer/utils/components/app_images.dart';
import 'package:ai_text_summrizer/utils/fonts/app_fonts.dart';
import 'package:ai_text_summrizer/view_model/api_request_tool_controller/api_request_tool_controller.dart';
import 'package:ai_text_summrizer/view_model/home_controller/home_controller.dart';
import 'package:ai_text_summrizer/view_model/loading_controller/loading_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final controller = Get.put(LoadingController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// Step tick animation
    Future.delayed(const Duration(milliseconds: 500), () async {
      for (int i = 0; i < controller.steps.length; i++) {
        await Future.delayed(const Duration(seconds: 1));
        controller.currentStep.value = i + 1;
      }

      /// Navigate after all steps
      await Future.delayed(const Duration(seconds: 1));
      //  Get.find<SummarizerController>().summarize(text)
      if (Get.find<HomeController>().toolName.value == "AI Summarizer") {
        Get.find<ApiToolController>().summarize(
          Get.find<ApiToolController>().inputTextcontroller.text.toString(),
          0,
        );
        log('its index is ${Get.find<HomeController>().toolName.value} 0');
      } else if (Get.find<HomeController>().toolName.value ==
          "AI Paraphraser") {
        Get.find<ApiToolController>().summarize(
          Get.find<ApiToolController>().inputTextcontroller.text.toString(),
          1,
        );
        log('its index is ${Get.find<HomeController>().toolName.value} 1');
      } else if (Get.find<HomeController>().toolName.value == "AI Humanizer") {
        log('its index is ${Get.find<HomeController>().toolName.value} 2');
        Get.find<ApiToolController>().summarize(
          Get.find<ApiToolController>().inputTextcontroller.text.toString(),
          2,
        );
      }
    });

    /// Animate dots in "It..."
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      controller.dotCount.value =
          (controller.dotCount.value % 3) + 1; // 1 → 2 → 3 → loop
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.loadingFlashIcon, height: 44),
            const SizedBox(height: 10),

            /// Animated Text with dots
            Text(
              "AI is Working",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontFamily: AppFonts.roboto,
                fontWeight: FontWeight.bold,
                color: Appcolor.themeColor,
              ),
            ),

            Obx(
              () => Text(
                "on It${"." * controller.dotCount.value}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: AppFonts.roboto,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Replace with your gif
            Container(
              height: Get.height * 0.3,
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(0.1),
              ),
              child: Image.asset(
                AppImages.homeScgif,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 40),

            /// Steps
            Obx(
              () => Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(controller.steps.length, (index) {
                  bool isDone = index < controller.currentStep.value;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  isDone
                                      ? Colors.transparent
                                      : Color(0xffCCCCCC),
                            ),
                            color:
                                isDone
                                    ? Appcolor.themeColor
                                    : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Image.asset(AppImages.check_icon, height: 8),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          controller.steps[index],
                          style: TextStyle(
                            fontSize: 13.5,
                            fontFamily: AppFonts.roboto,
                            fontWeight: FontWeight.w400,

                            color: isDone ? Colors.black : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
