import 'package:flutter/material.dart';
import 'package:movies_app/utils/size_utils.dart';

class ScreenShotsFilmWidget extends StatelessWidget {
  ScreenShotsFilmWidget({super.key, required this.image});

  String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.scaleWidth(15),
        vertical: context.scaleHeight(15),
      ),
      child: Container(
        height: context.scaleHeight(160),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Image.asset(image, fit: BoxFit.fill),
      ),
    );
  }
}
