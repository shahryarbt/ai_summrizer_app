import 'dart:developer';

import 'package:ai_text_summrizer/utils/components/app_colors.dart';
import 'package:ai_text_summrizer/utils/components/app_images.dart';
import 'package:ai_text_summrizer/utils/fonts/app_fonts.dart';
import 'package:ai_text_summrizer/view/result_view/widgets/download_bottom_sheet_widget.dart';
import 'package:ai_text_summrizer/view_model/result_controller/result_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ResultScreenView extends StatefulWidget {
  ResultScreenView({super.key});

  @override
  State<ResultScreenView> createState() => _ResultScreenViewState();
}

class _ResultScreenViewState extends State<ResultScreenView>
    with TickerProviderStateMixin {
  final controller = Get.put(ResultController());

  final TextEditingController originalTextcontroller = TextEditingController();
  final TextEditingController humarizeTextcontroller = TextEditingController();

  int get wordCount {
    if (originalTextcontroller.text.trim().isEmpty) return 0;
    return originalTextcontroller.text.trim().split(RegExp(r'\s+')).length;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    originalTextcontroller.text =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
    humarizeTextcontroller.text =
        "labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.";
  }

  @override
  Widget build(BuildContext context) {
    var tabController = TabController(length: 2, vsync: this);
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
          "Result",
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
                height: size.height * 0.45,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                            height: 35,
                            child: TabBar(
                              onTap: (value) {
                                controller.tabIndex.value = value;
                              },
                              indicatorColor: Appcolor.themeColor,
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelPadding: EdgeInsets.symmetric(
                                horizontal: 6,
                                // vertical: 6,
                              ),
                              labelStyle: TextStyle(fontSize: 14),
                              dividerColor: Color(0xffF3F3F3),
                              dividerHeight: 2,
                              controller: tabController,
                              tabs: [
                                Tab(text: 'Original Text'),
                                Tab(text: "Humarize Text"),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: Get.width * 0.2,
                          color: Color(0xffF3F3F3),
                          height: 2,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Obx(
                      () => Expanded(
                        child:
                            controller.tabIndex.value == 0
                                ? TextField(
                                  controller: originalTextcontroller,
                                  onChanged: (_) => setState(() {}),
                                  maxLines: null,
                                  expands: true,
                                  keyboardType: TextInputType.multiline,
                                  style: const TextStyle(
                                    fontFamily: AppFonts.roboto,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: 13,
                                  ),
                                  enabled: false,
                                  decoration: const InputDecoration(
                                    hintText:
                                        "Type or paste your content here..",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      fontFamily: AppFonts.roboto,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
                                  ),
                                )
                                : TextField(
                                  controller: humarizeTextcontroller,
                                  onChanged: (_) => setState(() {}),
                                  maxLines: null,
                                  expands: true,
                                  keyboardType: TextInputType.multiline,
                                  style: const TextStyle(
                                    fontFamily: AppFonts.roboto,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: 13,
                                  ),
                                  enabled: false,
                                  decoration: const InputDecoration(
                                    hintText:
                                        "Type or paste your content here..",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      fontFamily: AppFonts.roboto,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13,
                                    ),
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
                          width: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xffFAFAFA),
                            border: Border.all(color: const Color(0xffF3F3F3)),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Clipboard.setData(
                                ClipboardData(text: controller.text.toString()),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Text copied to clipboard!"),
                                ),
                              );
                              // TODO: Paste logic
                            },
                            child: Image.asset(
                              AppImages.copyIcon,
                              height: 20,
                              width: 20,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: 36,
                          width: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color(0xffFAFAFA),
                            border: Border.all(color: const Color(0xffF3F3F3)),
                          ),
                          child: TextButton(
                            onPressed: () {
                              // TODO: Paste logic
                            },
                            child: Image.asset(
                              AppImages.shareIcon,
                              height: 20,
                              width: 20,
                              fit: BoxFit.cover,
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
                              Get.bottomSheet(
                                BottomSheetWidget(),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                              );
                              // TODO: Upload logic
                            },
                            icon: Image.asset(
                              AppImages.downloadIcon,
                              height: 20,
                              width: 20,
                            ),
                            label: const Text(
                              "Download",
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
              SizedBox(height: Get.height * 0.01),
              Text(
                'What to explore more?',
                style: TextStyle(
                  fontFamily: AppFonts.roboto,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              _toolTile(
                AppImages.aiParaphraser,
                'AI Paraphraser',
                'Rephrase content with natural flow',
                Alignment.centerRight,
                Alignment.centerLeft,
              ),
              // SizedBox(height: 8),
              _toolTile(
                AppImages.aiParaphraser,
                'AI Humanizer',
                'Make AI text sound more human',
                Alignment.centerLeft,
                Alignment.centerRight,
              ),
            ],
          ),
        ),
      ),

      // ✅ Fixed Bottom Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () {},
          // _controller.text.trim().isEmpty
          //     ? null
          //     : () {
          //       // TODO: Humanizer Logic
          //     },
          child: Container(
            height: 46,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Appcolor.themeColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Humanize Again',
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

  Widget _toolTile(
    String icon,
    String title,
    String subtitle,
    AlignmentGeometry begin,
    AlignmentGeometry end,
  ) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Appcolor.themeColor.withOpacity(0.4), Colors.transparent],
            begin: begin,
            end: end,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          margin: const EdgeInsets.all(1.5), // border thickness
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Appcolor.themeColor.withOpacity(0.1),
              ),
              child: Image.asset(icon, height: 26),
            ),
            title: Text(
              title,
              style: TextStyle(
                fontFamily: AppFonts.roboto,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                fontFamily: AppFonts.roboto,
                color: Color(0xff5E626C),
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
        ),
      ),
    );
  }
}
