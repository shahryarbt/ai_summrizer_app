import 'package:ai_text_summrizer/utils/components/app_colors.dart';
import 'package:ai_text_summrizer/utils/components/app_images.dart';
import 'package:ai_text_summrizer/utils/fonts/app_fonts.dart';
import 'package:ai_text_summrizer/view/input_view/input_screen_view.dart';
import 'package:ai_text_summrizer/view/pro_screen/pro_screen1.dart';
import 'package:ai_text_summrizer/view_model/home_controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController _homeController = Get.put(HomeController());
  final List<Map<String, dynamic>> features = [
    {
      "icon": AppImages.ai_summarizer,
      "title": "AI Summarizer",
      "subtitle": "Get the main idea in just a few lines",
    },
    {
      "icon": AppImages.aiParaphraser,
      "title": "AI Paraphraser",
      "subtitle": "Rephrase content with natural flow",
    },
    {
      "icon": AppImages.ai_humanizer,
      "title": "AI Humanizer",
      "subtitle": "Make AI text sound more human",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundColor,

      /// APP BAR LIKE TOP BANNER
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Banner with Gradient
            ///
            Stack(
              children: [
                Container(
                  height: Get.height * 0.25,
                  width: double.infinity,
                  color: Colors.white, // tumhara background
                  child: Transform.translate(
                    offset: const Offset(130, -50), // x=right shift, y=up shift
                    child: Image.asset(
                      AppImages.homeScgif,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: Get.height * 0.04,
                  left: 20,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => ProScreen());
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [Color(0xffB425E2), Color(0xffE8888D)],
                        ),
                      ),
                      child: Image.asset(AppImages.pro, height: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 4),

                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.19),
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: features.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item = features[index];

                      // Gradient direction alternate hoga
                      final Alignment begin =
                          index.isEven
                              ? Alignment.centerLeft
                              : Alignment.centerRight;
                      final Alignment end =
                          index.isEven
                              ? Alignment.centerRight
                              : Alignment.centerLeft;

                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Appcolor.themeColor.withOpacity(0.4),
                                Colors.transparent,
                              ],
                              begin: begin,
                              end: end,
                            ),
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
                                Get.to(() => AiHumanizerScreen());
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  top: Get.height * 0.12,
                  left: 20,
                  child: Text(
                    "Summarize, simplify,\nstay focused",
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

            // Expanded(
            //   child: ListView.builder(
            //     padding: const EdgeInsets.all(16),
            //     itemCount: features.length,
            //     itemBuilder: (context, index) {
            //       final item = features[index];

            //       // Gradient direction alternate hoga
            //       final Alignment begin =
            //           index.isEven
            //               ? Alignment.centerLeft
            //               : Alignment.centerRight;
            //       final Alignment end =
            //           index.isEven
            //               ? Alignment.centerRight
            //               : Alignment.centerLeft;

            //       return GestureDetector(
            //         onTap: () {},
            //         child: Container(
            //           margin: const EdgeInsets.only(top: 8),
            //           decoration: BoxDecoration(
            //             gradient: LinearGradient(
            //               colors: [
            //                 Appcolor.themeColor.withOpacity(0.4),
            //                 Colors.transparent,
            //               ],
            //               begin: begin,
            //               end: end,
            //             ),
            //             borderRadius: BorderRadius.circular(16),
            //           ),
            //           child: Container(
            //             padding: EdgeInsets.symmetric(vertical: 5),
            //             margin: const EdgeInsets.all(1.5), // border thickness
            //             decoration: BoxDecoration(
            //               color: Colors.white,
            //               borderRadius: BorderRadius.circular(14),
            //             ),
            //             child: ListTile(
            //               leading: Container(
            //                 padding: const EdgeInsets.all(14),
            //                 decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(12),
            //                   color: Appcolor.themeColor.withOpacity(0.1),
            //                 ),
            //                 child: Image.asset(item['icon'], height: 26),
            //               ),
            //               title: Text(
            //                 item["title"],
            //                 style: TextStyle(
            //                   fontFamily: AppFonts.roboto,
            //                   fontWeight: FontWeight.w600,
            //                   fontSize: 16,
            //                 ),
            //               ),
            //               subtitle: Text(
            //                 item["subtitle"],
            //                 style: TextStyle(
            //                   fontSize: 12,
            //                   fontFamily: AppFonts.roboto,
            //                   color: Color(0xff5E626C),
            //                 ),
            //               ),
            //               trailing: const Icon(
            //                 Icons.arrow_forward_ios,
            //                 size: 16,
            //               ),
            //               onTap: () {
            //                 Get.to(() => AiHumanizerScreen());
            //               },
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
