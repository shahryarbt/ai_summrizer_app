import 'package:get/get.dart';

class ResultController extends GetxController {
  var text = ''.obs;
  final tabIndex = 0.obs;
  var selectedFormat = "".obs;

  void selectFormat(String format) {
    selectedFormat.value = format;
  }
}
