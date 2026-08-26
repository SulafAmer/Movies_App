import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_styles.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/size_utils.dart';

typedef OnChanged = void Function(String)?;
typedef OnValidator = String? Function(String?)?;

class TextFieldWidget extends StatelessWidget {
  final Widget? sufIcon;
  final Widget? prefIcon;
  final String hintDisplayedTxt;
  final int? lines;
  Color? fillColor;
  final TextEditingController? controller;
  final OnChanged onChanged;
  final OnValidator validator;
  final double? prefixHeight;
  final double? prefixWidth;
  final double? suffixHeight;
  final double? suffixWidth;

  // جديد: يتحكم في إخفاء/إظهار النص (مهم لحقول الباسورد)
  final bool obscureText;

  // جديد: بيتنفذ لما المستخدم يدوس على أيقونة الـ suffix (زي أيقونة العين)
  final VoidCallback? onSuffixTap;

  TextFieldWidget({
    super.key,
    this.sufIcon,
    required this.hintDisplayedTxt,
    this.prefIcon,
    this.lines,
    this.onChanged,
    this.controller,
    this.validator,
    this.prefixHeight,
    this.prefixWidth,
    this.suffixHeight,
    this.suffixWidth,
    this.obscureText = false,
    this.onSuffixTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      maxLines: obscureText ? 1 : (lines ?? 1),
      decoration: InputDecoration(
        fillColor: AppColors.darkGrayColor,
        filled: true,
        contentPadding: EdgeInsets.symmetric(
          vertical: context.scaleHeight(12),
          horizontal: context.scaleWidth(16),
        ),
        hintText: hintDisplayedTxt,
        hintStyle: AppStyles.regular16White,
        prefixIcon: prefIcon != null
            ? SizedBox(
          height: prefixHeight,
          width: prefixWidth,
          child: prefIcon,
        )
            : null,
        prefixIconConstraints: BoxConstraints(
          minWidth:
          context.scaleWidth(40) +
              context.scaleWidth(35), // مساحة الأيقونة + padding
          minHeight: 0,
        ),

        // لو فيه onSuffixTap، بنلف الأيقونة بـ GestureDetector عشان تبقى قابلة للضغط
        suffixIcon: sufIcon != null
            ? GestureDetector(
          onTap: onSuffixTap,
          child: SizedBox(
            height: suffixHeight,
            width: suffixWidth,
            child: sufIcon,
          ),
        )
            : null,
        suffixIconConstraints: BoxConstraints(
          minWidth: context.scaleWidth(20) + context.scaleWidth(30),
          minHeight: 0,
        ),

        focusedBorder: _OutlineBorderBulider(context, Colors.transparent),
        enabledBorder: _OutlineBorderBulider(
          // ← ده اللي كان ناقص
          context,
          Colors.transparent,
        ),
        errorBorder: _OutlineBorderBulider(context, AppColors.redColor),
        focusedErrorBorder: _OutlineBorderBulider(context, AppColors.redColor),
        errorStyle: TextStyle(color: AppColors.redColor),
      ),
    );
  }
}

OutlineInputBorder _OutlineBorderBulider(
    BuildContext context,
    Color? colorUsed,
    ) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: colorUsed ?? Colors.transparent),
    gapPadding: 1.5,
  );
}