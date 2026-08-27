import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

typedef onFilmClicked = void Function(int);

class FilmPosterWidget extends StatelessWidget {
  double boxHeight;
  double boxWidth;
  double borderRadius;
  String filmImage;
  String filmRate;
  double? horizontalMargin;
  double? verticaMargin;
  int filmId;



  FilmPosterWidget({
    super.key,
    required this.boxHeight,
    required this.boxWidth,
    required this.borderRadius,
    required this.filmImage,
    required this.filmRate,
    this.horizontalMargin,
    this.verticaMargin,
    required this.filmId

  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.movieDetailsScreenRouteName,
            arguments: filmId);
      },
      child: Container(
        alignment: AlignmentDirectional.topStart,
        height: context.scaleHeight(boxHeight),
        width: context.scaleWidth(boxWidth),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          image: DecorationImage(
              image: NetworkImage(filmImage), fit: BoxFit.fill),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.transparentBlackColor,
          ),
          alignment: Alignment.center,
          height: context.scaleHeight(30),
          width: context.scaleWidth(58),
          margin: EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(filmRate, style: AppStyles.regular16White),
              Icon(Icons.star, color: AppColors.yellowColor),
            ],
          ),
        ),
      ),
    );
  }
}