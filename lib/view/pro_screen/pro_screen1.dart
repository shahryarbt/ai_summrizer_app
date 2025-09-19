import 'package:ai_text_summrizer/utils/components/app_colors.dart';
import 'package:ai_text_summrizer/utils/components/app_images.dart';
import 'package:ai_text_summrizer/utils/components/response_config.dart';
import 'package:ai_text_summrizer/utils/fonts/app_fonts.dart';
import 'package:flutter/material.dart';
// import 'size_config.dart'; // yahan tumhari SizeConfig wali file import hogi

class ProScreen extends StatefulWidget {
  const ProScreen({super.key});

  @override
  State<ProScreen> createState() => _ProScreenState();
}

class _ProScreenState extends State<ProScreen> {
  int selectedPlan = 1;

  final List<Map<String, dynamic>> plans = [
    {"title": "Weekly Plan", "price": "Rs 0,000", "duration": "per year"},
    {"title": "Monthly Plan", "price": "Rs 0,000", "duration": "per year"},
    {"title": "Yearly Plan", "price": "Rs 0,000", "duration": "per year"},
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: Appcolor.backgroundColor,
      body: Container(
        // height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff4D6DF9).withOpacity(0.4),
              Color(0xff4D6DF9).withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: SizeConfig.h(20),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    SizedBox(height: SizeConfig.h(6)),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     Image.asset(
                    //       AppImages.pro_screen_2_icon,
                    //       height: 80,
                    //       fit: BoxFit.cover,
                    //       width: double.infinity,
                    //     ),
                    //   ],
                    // ),
                    SizedBox(height: SizeConfig.h(6)),

                    // Title
                    Row(
                      children: [
                        Text(
                          "Unlock Premium\n& Get More Done",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: SizeConfig.sp(24),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.h(6)),
                    FeatureTile(
                      icon: AppImages.staric,
                      text: "Unlimited Summarizer, Humanizer & Paraphraser",
                    ),
                    FeatureTile(
                      icon: AppImages.flash_yellow,
                      text: "Faster & Smoother Results",
                    ),
                    FeatureTile(
                      icon: AppImages.books,
                      text: "Access Without Limits – Use anytime, anywhere",
                    ),
                    FeatureTile(
                      icon: AppImages.ban,
                      text: "Ad-Free Experience – No distractions, just focus",
                    ),

                    SizedBox(height: SizeConfig.h(6)),
                    // Plans
                    Column(
                      children: List.generate(plans.length, (index) {
                        final isSelected = selectedPlan == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPlan = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: SizeConfig.h(6)),
                            padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.h(14),
                              horizontal: SizeConfig.w(16),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                SizeConfig.w(14),
                              ),
                              border: Border.all(
                                color:
                                    isSelected
                                        ? Appcolor.themeColor
                                        : Colors.grey.shade300,
                                width: isSelected ? 2 : 1,
                              ),
                              color:
                                  isSelected
                                      ? Colors.blue.withOpacity(0.05)
                                      : Colors.white,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  plans[index]["title"],
                                  style: TextStyle(
                                    fontSize: SizeConfig.sp(14),
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      plans[index]["price"],
                                      style: TextStyle(
                                        fontSize: SizeConfig.sp(16),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      plans[index]["duration"],
                                      style: TextStyle(
                                        fontSize: SizeConfig.sp(12),
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 4),
                    // Free Trial Button
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(56),
                        gradient: LinearGradient(
                          colors: [Color(0xffB425E2), Color(0xffE8888D)],
                        ),
                      ),
                      height: SizeConfig.h(50),
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Start your free trial",
                          style: TextStyle(
                            fontFamily: AppFonts.roboto,
                            fontSize: SizeConfig.sp(16),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.h(8)),
                    Spacer(),
                    // Footer
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Color(0xff00BA00),
                              size: 18,
                            ),
                            Text(
                              "  No Payment Now",
                              style: TextStyle(
                                fontSize: SizeConfig.sp(14),
                                color: Color(0xff00BA00),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: SizeConfig.h(4)),
                        Text(
                          "No Commitment. Cancel anytime",
                          style: TextStyle(
                            fontSize: SizeConfig.sp(13),
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: SizeConfig.h(10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Privacy Policy |",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: SizeConfig.sp(12),
                                color: Colors.black45,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            Text(
                              " Terms & Conditions |",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: SizeConfig.sp(12),
                                decoration: TextDecoration.underline,
                                color: Colors.black45,
                              ),
                            ),
                            Text(
                              " Restore Purchase",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: SizeConfig.sp(12),
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: SizeConfig.h(8)),
                      ],
                    ),
                  ],
                ),
              ),
              // top icon
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      AppImages.pro_screen_2_icon,
                      height: 80,
                      fit: BoxFit.cover,
                      // width: double.infinity,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureTile extends StatelessWidget {
  final String icon;
  final String text;

  const FeatureTile({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.h(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(icon, height: 14, width: 14),
          ),
          SizedBox(width: SizeConfig.w(10)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: SizeConfig.sp(14),
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
