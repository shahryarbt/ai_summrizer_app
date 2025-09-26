import 'dart:developer';
import 'dart:io';

import 'package:ai_text_summrizer/services/adManager.dart';
import 'package:ai_text_summrizer/services/remote_config_service.dart';
import 'package:ai_text_summrizer/utils/components/app_colors.dart';
import 'package:ai_text_summrizer/utils/components/app_images.dart';
import 'package:ai_text_summrizer/utils/fonts/app_fonts.dart';
import 'package:ai_text_summrizer/view/loading_view/loading_screen.dart';
import 'package:ai_text_summrizer/view_model/api_request_tool_controller/api_request_tool_controller.dart';
import 'package:ai_text_summrizer/view_model/home_controller/home_controller.dart';
import 'package:ai_text_summrizer/view_model/result_controller/result_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';

// class AiHumanizerController extends GetxController {
//   var text = ''.obs;
// }

class InputScreen extends StatefulWidget {
  InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final controller = Get.put(ApiToolController());
  final resultController = Get.put(ResultController());

  int get wordCount {
    if (controller.inputTextcontroller.text.trim().isEmpty) return 0;
    return controller.inputTextcontroller.text
        .trim()
        .split(RegExp(r'\s+'))
        .length;
  }

  Future<void> _pasteText() async {
    ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data != null && data.text != null) {
      setState(() {
        controller.inputTextcontroller.text =
            data.text!; // paste text into TextField
      });
    }
  }

  File? _file;
  NativeAd? _nativeAd;
  bool _isLoaded = false;
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
  void initState() {
    // TODO: implement initState
    super.initState();

    AdManager.loadBannerAd(context: context);
    _loadAd();
  }

  void _loadAd() {
    _nativeAd = NativeAd(
      adUnitId: 'ca-app-pub-3940256099942544/2247696110', // ✅ Test Native Ad ID
      factoryId: 'listTileMedium', // ✅ same as MainActivity.kt
      // factoryId: 'listTileMedium', // ✅ same as MainActivity.kt
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('Failed to load native ad: $error');
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    AdManager.disposeBanner();
    super.dispose();
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
        title: Obx(
          () => Text(
            Get.find<HomeController>().toolName.value,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
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
              RemoteConfigService().input_screen_native_OR_banner == 0
                  ? Column(
                    children: [
                      AdManager.getBannerWidget(),
                      SizedBox(height: 10),
                    ],
                  )
                  : SizedBox.shrink(),
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
                        controller: controller.inputTextcontroller,
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
              SizedBox(height: 10),

              // Text('data${Get.find<SummarizerController>().result}'),
              RemoteConfigService().input_screen_native_OR_banner == 1
                  ? _isLoaded
                      ? Container(
                        // color: Colors.white,
                        // height: 100,
                        height: 234,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: AdWidget(ad: _nativeAd!),
                      )
                      : const SizedBox.shrink()
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),

      // ✅ Fixed Bottom Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap:
              controller.inputTextcontroller.text.trim().isEmpty
                  ? null
                  : () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    log('tapped');

                    Get.to(() => LoadingScreen());
                  },
          child: Container(
            height: 46,
            width: double.infinity,
            decoration: BoxDecoration(
              color:
                  controller.inputTextcontroller.text.trim().isEmpty
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
                  Obx(
                    () => Text(
                      'Make it ${Get.find<HomeController>().toolName.value.replaceAll("AI ", "")}',
                      style: TextStyle(
                        fontFamily: AppFonts.roboto,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
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
