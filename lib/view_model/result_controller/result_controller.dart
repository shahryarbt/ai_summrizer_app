import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultController extends GetxController {
  // final TextEditingController originalTextcontroller = TextEditingController();
  // final TextEditingController humarizeTextcontroller = TextEditingController();
  final originalText = ''.obs;
  final humanizedText = ''.obs;
  var text = ''.obs;
  final tabIndex = 0.obs;
  var selectedFormat = "".obs;

  void selectFormat(String format) {
    selectedFormat.value = format;
  }
}
