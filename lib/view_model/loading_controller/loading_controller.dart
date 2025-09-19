import 'dart:async';

import 'package:ai_text_summrizer/view/result_view/result_view_screen.dart';
import 'package:get/get.dart';

class LoadingController extends GetxController {
  var currentStep = 0.obs;
  var dotCount = 1.obs;

  final List<String> steps = [
    "Analyzing your input...",
    "Generating smart results...",
    "Optimizing accuracy...",
    "Almost ready!",
  ];

  @override
  void onInit() {
    super.onInit();

    /// Step tick animation
    Future.delayed(const Duration(milliseconds: 500), () async {
      for (int i = 0; i < steps.length; i++) {
        await Future.delayed(const Duration(seconds: 1));
        currentStep.value = i + 1;
      }

      /// Navigate after all steps
      await Future.delayed(const Duration(seconds: 1));
      Get.off(() => ResultScreenView());
    });

    /// Animate dots in "It..."
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      dotCount.value = (dotCount.value % 3) + 1; // 1 → 2 → 3 → loop
    });
  }
}
