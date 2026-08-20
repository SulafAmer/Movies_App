import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class ProfileTextField extends StatelessWidget {
  final String iconPath;
  final String hint;
  final TextEditingController? controller;
  final bool enabled;

  const ProfileTextField({
    super.key,
    required this.iconPath,
    required this.hint,
    this.controller,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.scaleHeight(56),
      padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(16)),
      decoration: BoxDecoration(
        color: AppColors.darkGrayColor,
        borderRadius: BorderRadius.circular(context.scaleWidth(16)),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            iconPath,
            width: context.scaleWidth(20),
            height: context.scaleWidth(20),
            colorFilter: ColorFilter.mode(
              AppColors.whiteColor,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: context.scaleWidth(12)),
          Expanded(
            child: TextField(
              controller: controller,
              enabled: enabled,
              style: AppStyles.regular16White,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: AppStyles.regular16White.copyWith(
                  color: AppColors.transparentWhiteColor,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
