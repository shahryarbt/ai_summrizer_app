import 'dart:io';

import 'package:ai_text_summrizer/utils/components/app_colors.dart';
import 'package:ai_text_summrizer/utils/components/app_images.dart';
import 'package:ai_text_summrizer/utils/fonts/app_fonts.dart';
import 'package:ai_text_summrizer/view/loading_view/loading_screen.dart';
import 'package:ai_text_summrizer/view/result_view/result_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AiHumanizerController extends GetxController {
  var text = ''.obs;
}

class AiHumanizerScreen extends StatefulWidget {
  AiHumanizerScreen({super.key});

  @override
  State<AiHumanizerScreen> createState() => _AiHumanizerScreenState();
}

class _AiHumanizerScreenState extends State<AiHumanizerScreen> {
  final controller = Get.put(AiHumanizerController());

  final TextEditingController _controller = TextEditingController();

  int get wordCount {
    if (_controller.text.trim().isEmpty) return 0;
    return _controller.text.trim().split(RegExp(r'\s+')).length;
  }

  Future<void> _pasteText() async {
    ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data != null && data.text != null) {
      setState(() {
        _controller.text = data.text!; // paste text into TextField
      });
    }
  }

  File? _file;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _file = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Appcolor.backgroundColor,
      appBar: AppBar(
        backgroundColor: Appcolor.backgroundColor,
        surfaceTintColor: Appcolor.backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          "AI Humanizer",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),

      // ✅ Main Body
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.04,
          vertical: size.height * 0.015,
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: 80, // space for bottom button
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Text Area
              Container(
                height: size.height * 0.48,
                padding: EdgeInsets.all(size.width * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xffC8C8C800).withOpacity(0.4),
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onChanged: (_) => setState(() {}),
                        maxLines: null,
                        expands: true,
                        // keyboardType: TextInputType.multiline,
                        style: const TextStyle(
                          fontFamily: AppFonts.roboto,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                        decoration: const InputDecoration(
                          hintText: "Type or paste your content here..",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            fontFamily: AppFonts.roboto,
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Word counter + Paste/Upload buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "$wordCount words",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: size.width * 0.035,
                          ),
                        ),
                        Container(
                          height: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xffFAFAFA),
                            border: Border.all(color: const Color(0xffF3F3F3)),
                          ),
                          child: TextButton.icon(
                            onPressed: () {
                              _pasteText();
                              // TODO: Paste logic
                            },
                            icon: Image.asset(
                              AppImages.pastIcon,
                              height: 16,
                              width: 16,
                            ),
                            label: const Text(
                              "Paste text",
                              style: TextStyle(
                                color: Color(0xff1E1E1E),
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 36,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xffFAFAFA),
                            border: Border.all(color: const Color(0xffF3F3F3)),
                          ),
                          child: TextButton.icon(
                            onPressed: () {
                              _pickImage();
                              // TODO: Upload logic
                            },
                            icon: Image.asset(
                              AppImages.uploadIcons,
                              height: 16,
                              width: 16,
                            ),
                            label: const Text(
                              "Upload file",
                              style: TextStyle(
                                color: Color(0xff1E1E1E),
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // ✅ Fixed Bottom Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap:
              _controller.text.trim().isEmpty
                  ? null
                  : () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    // log('tapped');

                    Get.to(() => LoadingScreen());
                    // Get.to(() => ResultScreenView());
                    // TODO: Humanizer Logic
                  },
          child: Container(
            height: 46,
            width: double.infinity,
            decoration: BoxDecoration(
              color:
                  _controller.text.trim().isEmpty
                      ? Appcolor.themeColor.withOpacity(0.1)
                      : Appcolor.themeColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.flashIcon, height: 24, width: 24),
                  const SizedBox(width: 5),
                  const Text(
                    'Make it Humanizer',
                    style: TextStyle(
                      fontFamily: AppFonts.roboto,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
