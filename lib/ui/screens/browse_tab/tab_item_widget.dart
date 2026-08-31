import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class TabItemWidget extends StatelessWidget {
  TabItemWidget({super.key, required this.isSelected, required this.text});

  bool isSelected;
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.scaleHeight(10),
        horizontal: context.scaleWidth(20),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isSelected ? AppColors.yellowColor : AppColors.blackColor,
        border: Border.all(color: AppColors.yellowColor, width: 3),
      ),
      child: Text(
        text,
        style: isSelected ? AppStyles.bold20Black : AppStyles.bold20Yellow,
      ),
    );
  }
}
