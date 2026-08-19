import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/ui/widgets/film_poster_widget.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Container(
        height: context.scaleHeight(1000),
        child: SingleChildScrollView(
          child: Column(
            spacing: context.scaleHeight(5),
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.film1917),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.transparentBlackColor,
                        AppColors.blackColor,
                      ],
                      end: AlignmentGeometry.bottomCenter,
                      begin: AlignmentGeometry.topCenter,
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      spacing: context.scaleHeight(10),

                      children: [
                        Image.asset(AppImages.availableNow),
                        CarouselSlider.builder(
                          itemCount: 3,
                          itemBuilder: (context, index, realIndex) {
                            return FilmPosterWidget(
                              borderRadius: 20,
                              boxHeight: context.scaleHeight(351),
                              boxWidth: context.scaleHeight(250),
                              filmImage: AppImages.film1917,
                              filmRate: "7.7",
                              horizontalMargin: context.scaleWidth(6),
                            );
                          },
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            enlargeFactor: context.scaleHeight(0.34),
                            viewportFraction: context.scaleWidth(0.62),
                            height: context.scaleHeight(360),
                            initialPage: 0,

                            onPageChanged: (index, reason) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Image.asset(AppImages.watchNow),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.action,
                    style: AppStyles.regular20White,
                  ),
                  Text(
                    AppLocalizations.of(context)!.see_more,
                    style: AppStyles.regular16Yellow,
                  ),
                ],
              ),

              SizedBox(
                height: context.scaleHeight(280),
                child: ListView.separated(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return SizedBox(width: context.scaleWidth(9));
                  },
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.scaleWidth(8)),
                      child: FilmPosterWidget(
                        boxHeight: context.scaleHeight(240),
                        boxWidth: context.scaleWidth(200),
                        borderRadius: 20,
                        filmImage: AppImages.blackWidowFilm,
                        filmRate: "7.7",
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
