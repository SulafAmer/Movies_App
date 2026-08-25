import 'package:flutter/material.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/ui/screens/movie_details/film_info_widget.dart';
import 'package:movies_app/ui/screens/movie_details/screen_shots_film_widget.dart';
import 'package:movies_app/ui/widgets/film_poster_widget.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: context.scaleHeight(750),

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
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.scaleWidth(15),
                    ),
                    child: Column(
                      spacing: context.scaleHeight(170),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            ),

                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.bookmark, color: Colors.white),
                            ),
                          ],
                        ),
                        Image.asset(AppImages.playVideoImage),
                        Container(
                          child: Column(
                            spacing: context.scaleHeight(10),
                            children: [
                              Text(
                                "Doctor Strange in the Multiverse of Madness",
                                style: AppStyles.bold24White,
                                textAlign: TextAlign.center,
                              ),
                              Text("2012", style: AppStyles.bold20Grey),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.redColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: context.scaleHeight(15),
                                  ),
                                  width: double.infinity,
                                  child: Text(
                                    AppLocalizations.of(context)!.watch,
                                    style: AppStyles.bold20White,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilmInfoWidget(
                    data: "15",
                    icon: Icons.favorite,
                    style: AppStyles.bold24White,
                    borderRadius: 16,
                  ),
                  FilmInfoWidget(
                    data: "90",
                    icon: Icons.access_time_filled,
                    style: AppStyles.bold24White,
                    borderRadius: 16,
                  ),
                  FilmInfoWidget(
                    data: "7.6",
                    icon: Icons.star,
                    style: AppStyles.bold24White,
                    borderRadius: 16,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(15)),
              child: Text(
                AppLocalizations.of(context)!.screen_shots,
                style: AppStyles.bold24White,
              ),
            ),
            Container(
              height: context.scaleHeight(600),
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ScreenShotsFilmWidget(image: AppImages.film1917);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(15)),
              child: Text(
                AppLocalizations.of(context)!.similar,
                style: AppStyles.bold24White,
              ),
            ),
            Container(
              height: context.scaleHeight(600),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return FilmPosterWidget(
                    boxHeight: 500,
                    boxWidth: 189,
                    borderRadius: 16,
                    filmImage: AppImages.film1917,
                    filmRate: "7.7",
                    horizontalMargin: context.scaleWidth(15),
                    verticaMargin: context.scaleWidth(10),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 12 / 15,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(15)),
              child: Text(
                AppLocalizations.of(context)!.summary,
                style: AppStyles.bold24White,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(15)),
              child: Text(
                "Following the events of Spider-Man No Way Home, Doctor Strange unwittingly casts a forbidden spell that accidentally opens up the multiverse. With help from Wong and Scarlet Witch, Strange confronts various versions of himself as well as teaming up with the young America Chavez while traveling through various realities and working to restore reality as he knows it. Along the way, Strange and his allies realize they must take on a powerful new adversary who seeks to take over the multiverse.—Blazer346",
                style: AppStyles.regular16lightGrey,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(15)),
              child: Text(
                AppLocalizations.of(context)!.cast,
                style: AppStyles.bold24White,
              ),
            ),
            Container(
              height: context.scaleHeight(670),
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(height: context.scaleHeight(10));
                },
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.scaleWidth(15),
                    ),
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: context.scaleHeight(140),
                      ),
                      padding: EdgeInsets.all(context.scaleWidth(15)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.darkGrayColor,
                      ),
                      child: Row(
                        spacing: context.scaleWidth(15),
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Image.asset(
                              AppImages.film1917,
                              fit: BoxFit.fill,
                            ),
                            width: context.scaleWidth(100),
                            height: context.scaleHeight(100),
                          ),

                          Expanded(
                            child: Column(
                              spacing: context.scaleHeight(10),
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Name : Scarlet johanson",
                                  style: AppStyles.regular20White,
                                ),
                                Text(
                                  "Character : Scarlet johanson   ",
                                  style: AppStyles.regular20White,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            /////////////////////////////
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(15)),
              child: Text(
                AppLocalizations.of(context)!.genres,
                style: AppStyles.bold24White,
              ),
            ),
            Container(
              height: context.scaleHeight(200),
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FilmInfoWidget(
                      data: "Action",
                      style: AppStyles.regular16White,
                      borderRadius: 12,
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 12 / 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
