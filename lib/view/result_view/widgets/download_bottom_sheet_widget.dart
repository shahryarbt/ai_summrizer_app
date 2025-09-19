import 'package:ai_text_summrizer/utils/components/app_colors.dart';
import 'package:ai_text_summrizer/utils/components/app_images.dart';
import 'package:ai_text_summrizer/utils/fonts/app_fonts.dart';
import 'package:ai_text_summrizer/view_model/result_controller/result_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetWidget extends StatelessWidget {
  BottomSheetWidget({super.key});

  final ResultController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                "Choose format",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.roboto,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Obx(() {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                formatCard(
                  "TXT",
                  AppImages.txt_format_icon,
                  controller.selectedFormat.value == "TXT",
                ),
                formatCard(
                  "PDF",
                  AppImages.pdf_format_icon,
                  controller.selectedFormat.value == "PDF",
                ),
                formatCard(
                  "DOC",
                  AppImages.doc_format_icon,
                  controller.selectedFormat.value == "DOC",
                ),
              ],
            );
          }),
          const SizedBox(height: 25),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Appcolor.themeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(56),
              ),
            ),
            onPressed: () {
              Get.back();
              Get.snackbar(
                "Download",
                "${controller.selectedFormat.value} selected",
              );
            },
            child: Text(
              "Download",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.roboto,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget formatCard(String title, String icon, bool isSelected) {
    return GestureDetector(
      onTap: () => controller.selectFormat(title),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        width: Get.width * 0.28,
        decoration: BoxDecoration(
          color: Appcolor.themeColor.withOpacity(0.1),
          border: Border.all(
            color:
                isSelected
                    ? Appcolor.themeColor.withOpacity(0.2)
                    : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Image.asset(icon, height: 30),
            // Icon(icon, color: isSelected ? Colors.blue : Colors.grey, size: 30),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.blue : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
