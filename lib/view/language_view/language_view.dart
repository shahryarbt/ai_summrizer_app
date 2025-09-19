import 'package:ai_text_summrizer/utils/fonts/app_fonts.dart';
import 'package:ai_text_summrizer/view/onboarding_view/onboarding_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageSelectionScreen extends StatefulWidget {
  bool isFromSetting = false;
  LanguageSelectionScreen({super.key, this.isFromSetting = false});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  int selectedIndex = 3; // Default English selected

  final List<Map<String, String>> languages = [
    {"flag": "🇫🇷", "name": "French", "native": "(française)"},
    {"flag": "🇩🇪", "name": "German", "native": "(Deutsch)"},
    {"flag": "🇷🇺", "name": "Russia", "native": "(русский)"},
    {"flag": "🇺🇸", "name": "English", "native": "(Default)"},
    {"flag": "🇨🇳", "name": "Chinese", "native": "(中国人)"},
    {"flag": "🇰🇷", "name": "Korean", "native": "(한국인)"},
    {"flag": "🇮🇷", "name": "Persian", "native": "(فارسی)"},
    {"flag": "🇪🇸", "name": "Spanish", "native": "(Española)"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Choose Language",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (widget.isFromSetting) {
                        Get.back();
                      } else {
                        Get.to(() => OnboardingScreen());
                      }
                    },
                    child: Container(
                      height: 30,
                      width: 55,
                      decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(60),

                        color: Colors.blue,
                      ),
                      padding: const EdgeInsets.all(2),
                      child: Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 20,
                          weight: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Language List
            Expanded(
              child: ListView.builder(
                itemCount: languages.length,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                itemBuilder: (context, index) {
                  final isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Text(
                          languages[index]["flag"]!,
                          style: TextStyle(
                            fontSize: 24,
                            // fontFamily: 'assets/fonts/Roboto-Regular.ttf',
                          ),
                        ),
                        title: Text(
                          "${languages[index]["name"]!}${languages[index]["native"]!}",
                          style: TextStyle(
                            fontSize: 16,
                            // fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.black,

                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500, // Medium
                          ),
                        ),
                        // subtitle: Text(
                        //   ,
                        //   style: TextStyle(
                        //     color:
                        //         isSelected
                        //             ? Colors.white.withOpacity(0.9)
                        //             : Colors.grey,
                        //   ),
                        // ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
