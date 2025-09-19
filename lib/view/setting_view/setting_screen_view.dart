import 'package:ai_text_summrizer/utils/components/app_colors.dart';
import 'package:ai_text_summrizer/utils/components/app_images.dart';
import 'package:ai_text_summrizer/utils/components/response_config.dart';
import 'package:ai_text_summrizer/utils/fonts/app_fonts.dart';
import 'package:ai_text_summrizer/view/input_view/input_screen_view.dart';
import 'package:ai_text_summrizer/view/language_view/language_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> features = [
    {
      "icon": AppImages.language,
      "title": "Language",
      "subtitle": "Change your preferred app language",
    },
    {
      "icon": AppImages.rate_us_icon,
      "title": "Rate Us",
      "subtitle": "Tell us what you think on the store",
    },
    {
      "icon": AppImages.shareIcon,
      "title": "Share Us",
      "subtitle": "Invite friends to try the app",
    },
    {
      "icon": AppImages.terms_icon,
      "title": "Terms and Conditions",
      "subtitle": "Read our usage policies",
    },
    {
      "icon": AppImages.privcay_icon,
      "title": "Privacy Policy",
      "subtitle": "Learn how we protect your data",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundColor,

      /// APP BAR LIKE TOP BANNER
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top Banner with Gradient
              ///
              Stack(
                children: [
                  Container(
                    height: Get.height * 0.26,
                    width: double.infinity,
                    color: Colors.white, // tumhara background
                    child: Transform.translate(
                      offset: const Offset(
                        130,
                        -50,
                      ), // x=right shift, y=up shift
                      child: Image.asset(
                        AppImages.homeScgif,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Padding(
                    padding: EdgeInsets.only(top: Get.height * 0.26),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: features.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = features[index];

                        // Gradient direction alternate hoga
                        // final Alignment begin =
                        //     index.isEven
                        //         ? Alignment.centerLeft
                        //         : Alignment.centerRight;
                        // final Alignment end =
                        //     index.isEven
                        //         ? Alignment.centerRight
                        //         : Alignment.centerLeft;

                        return Container(
                          margin: const EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // gradient: LinearGradient(
                            //   colors: [
                            //     Appcolor.themeColor.withOpacity(0.4),
                            //     Colors.transparent,
                            //   ],
                            //   begin: begin,
                            //   end: end,
                            // ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            margin: const EdgeInsets.all(
                              1.5,
                            ), // border thickness
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
                                child: Image.asset(item['icon'], height: 26),
                              ),
                              title: Text(
                                item["title"],
                                style: TextStyle(
                                  fontFamily: AppFonts.roboto,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Text(
                                item["subtitle"],
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: AppFonts.roboto,
                                  color: Color(0xff5E626C),
                                ),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                              ),
                              onTap: () {
                                if (index == 0) {
                                  Get.to(
                                    () => LanguageSelectionScreen(
                                      isFromSetting: true,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Positioned(
                  //   top: Get.height * 0.04,
                  //   left: 20,
                  //   child:
                  // ),
                  Container(
                    height: SizeConfig.h(93),
                    margin: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: Get.height * 0.16,
                    ),
                    width: double.infinity,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [Color(0xffB425E2), Color(0xffE8888D)],
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Go Premium',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: AppFonts.roboto,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Get unlimited access to all AI tools and enhancements.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: AppFonts.roboto,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Image.asset(
                          AppImages.diamond_icon,
                          height: SizeConfig.h(77),
                          // color: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: Get.height * 0.05,
                    left: 20,
                    child: Text(
                      "Manage Settings \nEasily",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        // color: Colors.white,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
