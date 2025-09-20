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
  }
}
