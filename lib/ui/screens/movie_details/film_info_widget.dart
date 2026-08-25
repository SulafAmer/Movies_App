import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/size_utils.dart';

class FilmInfoWidget extends StatelessWidget {
  FilmInfoWidget({
    super.key,
    required this.data,
    this.icon,
    required this.style,
    required this.borderRadius,
  });

  String data;
  IconData? icon;
  TextStyle style;
  double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: AppColors.darkGrayColor,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.scaleWidth(30),
        vertical: context.scaleHeight(5),
      ),
      child: Row(
        spacing: context.scaleWidth(5),
        children: [
          icon != null ? Icon(icon, color: AppColors.yellowColor) : Container(),
          Text(data, style: style),
        ],
      ),
    );
  }
}
