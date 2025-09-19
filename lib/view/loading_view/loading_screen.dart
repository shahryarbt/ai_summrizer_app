import 'dart:async';
import 'package:ai_text_summrizer/utils/components/app_colors.dart';
import 'package:ai_text_summrizer/utils/components/app_images.dart';
import 'package:ai_text_summrizer/utils/fonts/app_fonts.dart';
import 'package:ai_text_summrizer/view_model/loading_controller/loading_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoadingController());

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
