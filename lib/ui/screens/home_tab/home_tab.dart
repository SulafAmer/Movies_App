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
                              boxHeight: 351,
                              boxWidth: 234,
                              filmImage: AppImages.film1917,
                              filmRate: "7.7",
                            );
                          },
                          options: CarouselOptions(
                            enlargeCenterPage: true,
                            enlargeFactor: 0.3,
                            viewportFraction: 0.4,
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
                height: context.scaleHeight(220),
                child: ListView.separated(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return SizedBox(width: context.scaleWidth(15));
                  },
                  itemBuilder: (context, index) {
                    return FilmPosterWidget(
                      boxHeight: 220,
                      boxWidth: 146,
                      borderRadius: 20,
                      filmImage: AppImages.film1917,
                      filmRate: "7.7",
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
