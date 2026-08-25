import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/size_utils.dart';
import '../../widgets/film_poster_widget.dart';
import '../../widgets/main_error_widget.dart';
import '../../widgets/main_loading_widget.dart';
import '../../widgets/movie_section.dart';
import 'cubit/movies_states.dart';
import 'cubit/movies_view_model.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: BlocBuilder<MoviesViewModel, MoviesStates>(
        builder: (context, state) {
          if (state is MovieSuccessState) {
            return SingleChildScrollView(
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
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: SafeArea(
                        child: Column(
                          spacing: context.scaleHeight(10),
                          children: [
                            Image.asset(AppImages.availableNow),

                            CarouselSlider.builder(
                              itemCount:
                              state.availableNowMovies.length,
                              itemBuilder:
                                  (context, index, realIndex) {
                                final movie =
                                state.availableNowMovies[index];

                                return FilmPosterWidget(
                                  borderRadius: 20,
                                  boxHeight: 351,
                                  boxWidth: 200,
                                  filmImage:
                                  movie.mediumCoverImage,
                                  filmRate:
                                  movie.rating.toStringAsFixed(1),
                                  horizontalMargin: 6,
                                );
                              },
                              options: CarouselOptions(
                                enlargeCenterPage: true,
                                enlargeFactor: 0.34,
                                viewportFraction: 0.62,
                                height:
                                context.scaleHeight(360),
                                initialPage: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Image.asset(AppImages.watchNow),

                  MovieSection(
                    title:
                    AppLocalizations.of(context)!.family,
                    movies: state.familyMovies,
                  ),

                  MovieSection(
                    title:
                    AppLocalizations.of(context)!.drama,
                    movies: state.dramaMovies,
                  ),

                  SizedBox(
                    height: context.scaleHeight(15),
                  ),
                ],
              ),
            );
          }

          if (state is MovieErrorState) {
            return MainErrorWidget(
              errorMesaage: state.errorMessage,
              onPressed: () {
                context
                    .read<MoviesViewModel>()
                    .getMovies();
              },
            );
          }

          return const MainLoadingWidget();
        },
      ),
    );
  }
}