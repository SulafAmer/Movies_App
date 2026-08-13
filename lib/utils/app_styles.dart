import 'dart:ui';

import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/utils/app_colors.dart';

class AppStyles {
  static TextStyle bold20Yellow = GoogleFonts.roboto(
    fontSize: 20,
    color: AppColors.yellowColor,
    fontWeight: FontWeight.w700,
  );
  static TextStyle bold20Black = GoogleFonts.roboto(
    fontSize: 20,
    color: AppColors.blackColor,
    fontWeight: FontWeight.w700,
  );

  static TextStyle semi20Black = GoogleFonts.roboto(
    fontSize: 20,
    color: AppColors.blackColor,
    fontWeight: FontWeight.w600,
  );

  static TextStyle bold24White = GoogleFonts.roboto(
    fontSize: 24,
    color: AppColors.whiteColor,
    fontWeight: FontWeight.w700,
  );

  static TextStyle regular16White = GoogleFonts.roboto(
    fontSize: 16,
    color: AppColors.whiteColor,
    fontWeight: FontWeight.w400,
  );

  static TextStyle medium36White = GoogleFonts.roboto(
    fontSize: 36,
    color: AppColors.whiteColor,
    fontWeight: FontWeight.w500,
  );

  static TextStyle regular20White = GoogleFonts.roboto(
    fontSize: 20,
    color: AppColors.whiteColor,
    fontWeight: FontWeight.w400,
  );

  static TextStyle regular16Yellow = GoogleFonts.roboto(
    fontSize: 16,
    color: AppColors.yellowColor,
    fontWeight: FontWeight.w400,
  );

  static TextStyle bold20White = GoogleFonts.roboto(
    fontSize: 20,
    color: AppColors.whiteColor,
    fontWeight: FontWeight.w700,
  );
}