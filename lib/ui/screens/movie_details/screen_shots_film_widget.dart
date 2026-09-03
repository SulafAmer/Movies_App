import 'package:flutter/material.dart';
import 'package:movies_app/utils/size_utils.dart';

class ScreenShotsFilmWidget extends StatelessWidget {
  ScreenShotsFilmWidget({super.key, required this.image});

  String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.scaleHeight(160),
      margin: EdgeInsets.symmetric(
        horizontal: context.scaleWidth(15),
        vertical: context.scaleHeight(15),
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Image.network(image, fit: BoxFit.fill,),
    );
  }
}
