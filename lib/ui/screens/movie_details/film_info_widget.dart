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
    this.horizontalPadding = 30,
  });

  String data;
  IconData? icon;
  TextStyle style;
  double borderRadius;
  double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: AppColors.darkGrayColor,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.scaleWidth(horizontalPadding),
        vertical: context.scaleHeight(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: AppColors.yellowColor,
            ),

          SizedBox(width: context.scaleWidth(5)),

          Text(
            data,
            style: style,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}