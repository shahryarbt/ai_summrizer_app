import 'package:ai_text_summrizer/utils/components/app_colors.dart';
import 'package:ai_text_summrizer/utils/components/response_config.dart';
import 'package:ai_text_summrizer/utils/fonts/app_fonts.dart';
import 'package:flutter/material.dart';

class HorizontalSelector extends StatefulWidget {
  const HorizontalSelector({super.key});

  @override
  State<HorizontalSelector> createState() => _HorizontalSelectorState();
}

class _HorizontalSelectorState extends State<HorizontalSelector> {
  final List<String> items = [
    "All",
    "Paraphraser",
    "Humanizer",
    "Summarizer",
    "Other",
  ];

  int selectedIndex = 0; // by default "All" selected hoga

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffF3F3F3)),
                color: isSelected ? Appcolor.themeColor : Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Text(
                  items[index],
                  style: TextStyle(
                    fontSize: SizeConfig.sp(12),
                    fontFamily: AppFonts.roboto,
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
