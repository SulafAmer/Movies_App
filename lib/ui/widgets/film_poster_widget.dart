import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class FilmPosterWidget extends StatelessWidget {
  final double boxHeight;
  final double boxWidth;
  final double borderRadius;
  final String filmImage;
  final String filmRate;
  final double? horizontalMargin;

  const FilmPosterWidget({
    super.key,
    required this.boxHeight,
    required this.boxWidth,
    required this.borderRadius,
    required this.filmImage,
    required this.filmRate,
    this.horizontalMargin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin ?? 0,
      ),
      height: context.scaleHeight(boxHeight),
      width: context.scaleWidth(boxWidth),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          alignment: AlignmentDirectional.topStart,
          children: [

            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: filmImage,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.error),
                ),
              ),
            ),

            // Rating
            Container(
              height: context.scaleHeight(30),
              width: context.scaleWidth(58),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.transparentBlackColor,
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    filmRate,
                    style: AppStyles.regular16White,
                  ),
                  const SizedBox(width: 3),
                  Icon(
                    Icons.star,
                    color: AppColors.yellowColor,
                    size: 18,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}