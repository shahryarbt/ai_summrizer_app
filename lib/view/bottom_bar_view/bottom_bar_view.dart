import 'package:ai_text_summrizer/utils/components/app_colors.dart';
import 'package:ai_text_summrizer/utils/components/app_images.dart';
import 'package:ai_text_summrizer/utils/fonts/app_fonts.dart';
import 'package:ai_text_summrizer/view/history_view/history_view.dart';
import 'package:ai_text_summrizer/view/home_view/home_view.dart';
import 'package:ai_text_summrizer/view/setting_view/setting_screen_view.dart';
import 'package:ai_text_summrizer/view/setting_view/widgets/logout_bottom_sheet_widget.dart';
import 'package:ai_text_summrizer/view_model/home_controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBarView extends StatefulWidget {
  const BottomBarView({super.key});

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
  final List screens = [const HomeScreen(), HistoryScreenView(), SettingView()];

  final List unSelected = [
    AppImages.home_icon,
    AppImages.history,
    AppImages.setting,
  ];

  final List selected = [
    AppImages.home_fill,
    AppImages.history_fill,
    AppImages.setting_fill,
  ];

  HomeController _homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_homeController.bottomBarIndex.value == 0) {
          showExitBottomSheet(context);
        } else {
          _homeController.bottomBarIndex.value = 0;
        }
        return false;
      },
      child: Scaffold(
        body: Obx(() => screens[_homeController.bottomBarIndex.value]),

        /// Bottom Navigation
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: Colors.transparent, // ripple color remove
            highlightColor: Colors.transparent, // long-press highlight remove
            hoverColor: Colors.transparent, // desktop/web hover bhi hata do
          ),
          child: Obx(
            () => BottomNavigationBar(
              currentIndex: _homeController.bottomBarIndex.value,
              backgroundColor: Colors.white,
              selectedLabelStyle: TextStyle(fontFamily: AppFonts.roboto),
              unselectedLabelStyle: TextStyle(fontFamily: AppFonts.roboto),
              selectedItemColor: Appcolor.themeColor,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                setState(() {
                  _homeController.bottomBarIndex.value = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(unSelected[0], height: 24),
                  activeIcon: Image.asset(selected[0], height: 24),
                  label: "AI Tools",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(unSelected[1], height: 24),
                  activeIcon: Image.asset(selected[1], height: 24),
                  label: "See History",
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(unSelected[2], height: 24),
                  activeIcon: Image.asset(selected[2], height: 24),
                  label: "Settings",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
