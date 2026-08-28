import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/ui/screens/movie_details/cubit/movie_details_states.dart';
import 'package:movies_app/ui/screens/movie_details/cubit/movie_details_view_model.dart';
import 'package:movies_app/ui/screens/movie_details/film_info_widget.dart';
import 'package:movies_app/ui/screens/movie_details/movie_suggestion.dart';
import 'package:movies_app/ui/screens/movie_details/screen_shots_film_widget.dart';
import 'package:movies_app/ui/widgets/main_error_widget.dart';
import 'package:movies_app/ui/widgets/main_loading_widget.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  MovieDetailsViewModel viewModel = MovieDetailsViewModel();

  @override
  Widget build(BuildContext context) {
    final int filmId =
    ModalRoute
        .of(context)!
        .settings
        .arguments as int;

    return BlocProvider(
      create: (context) {
        viewModel.getMovieDetails(filmId);
        return viewModel;
      },
      child: BlocBuilder<MovieDetailsViewModel, MovieDetailsStates>(
        builder: (context, state) {
          if (state is MovieDetailsLoadingState) {
            return MainLoadingWidget();
          }


          else if (state is MovieDetailsErrorState) {
            return MainErrorWidget(
              errorMesaage: state.errorMessage,
              onPressed: () {
                viewModel.getMovieDetails(filmId);
              },
            );
          }


          else if (state is MovieDetailsSuccessState) {
            final movie = state.movieDetails.data?.movie;

            if (movie == null) {
              return MainErrorWidget(
                errorMesaage: "Movie not found",
                onPressed: () {
                  viewModel.getMovieDetails(filmId);
                },
              );
            }


            final List<String> screenShots = [
              if (movie.largeScreenshotImage1 != null)
                movie.largeScreenshotImage1!,

              if (movie.largeScreenshotImage2 != null)
                movie.largeScreenshotImage2!,

              if (movie.largeScreenshotImage3 != null)
                movie.largeScreenshotImage3!,
            ];


            final cast = movie.cast ?? [];


            final genres = movie.genres ?? [];

            return Scaffold(
              backgroundColor: AppColors.blackColor,

              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: [

                    Container(
                      height: context.scaleHeight(750),

                      decoration: BoxDecoration(
                        image: movie.largeCoverImage != null
                            ? DecorationImage(
                          image: NetworkImage(
                            movie.largeCoverImage!,
                          ),
                          fit: BoxFit.fill,
                        )
                            : null,
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
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.scaleWidth(15),
                            ),

                            child: Column(
                              spacing: context.scaleHeight(170),

                              children: [


                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,

                                  children: [

                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },

                                      icon: const Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                      ),
                                    ),

                                    IconButton(
                                      onPressed: () {},

                                      icon: const Icon(
                                        Icons.bookmark,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),


                                Image.asset(
                                  AppImages.playVideoImage,
                                ),

                                Column(
                                  spacing: context.scaleHeight(10),

                                  children: [

                                    Text(
                                      movie.title ?? "",
                                      style: AppStyles.bold24White,
                                      textAlign: TextAlign.center,
                                    ),

                                    Text(
                                      "${movie.year ?? ""}",
                                      style: AppStyles.bold20Grey,
                                    ),

                                    ElevatedButton(
                                      onPressed: () {},

                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                        AppColors.redColor,

                                        shape:
                                        RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(15),
                                        ),
                                      ),

                                      child: Container(
                                        width: double.infinity,

                                        padding: EdgeInsets.symmetric(
                                          vertical:
                                          context.scaleHeight(15),
                                        ),

                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .watch,

                                          style:
                                          AppStyles.bold20White,

                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.scaleWidth(15),
                        vertical: context.scaleHeight(10),
                      ),

                      child: Wrap(
                        spacing: context.scaleWidth(8),
                        runSpacing: context.scaleHeight(8),
                        alignment: WrapAlignment.center,

                        children: [

                          SizedBox(
                            width: context.scaleWidth(125),

                            child: FilmInfoWidget(
                              data: "${movie.likeCount ?? 0}",
                              icon: Icons.favorite,
                              style: AppStyles.bold24White,
                              borderRadius: 16,
                              horizontalPadding: 0,
                            ),
                          ),

                          SizedBox(
                            width: context.scaleWidth(125),

                            child: FilmInfoWidget(
                              data: "${movie.runtime ?? 0}",
                              icon: Icons.access_time_filled,
                              style: AppStyles.bold24White,
                              borderRadius: 16,
                              horizontalPadding: 0,
                            ),
                          ),

                          SizedBox(
                            width: context.scaleWidth(125),

                            child: FilmInfoWidget(
                              data: "${movie.rating ?? 0}",
                              icon: Icons.star,
                              style: AppStyles.bold24White,
                              borderRadius: 16,
                              horizontalPadding: 0,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.scaleWidth(15),
                        vertical: context.scaleHeight(10),
                      ),

                      child: Text(
                        AppLocalizations.of(context)!
                            .screen_shots,

                        style: AppStyles.bold24White,
                      ),
                    ),


                    if (screenShots.isNotEmpty)
                      SizedBox(
                        height: context.scaleHeight(560),

                        child: ListView.builder(
                          padding: EdgeInsets.zero,

                          physics:
                          const NeverScrollableScrollPhysics(),

                          itemCount: screenShots.length,

                          itemBuilder: (context, index) {
                            return ScreenShotsFilmWidget(
                              image: screenShots[index],
                            );
                          },
                        ),
                      ),

                    MovieSuggestion(
                      filmId: filmId,
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.scaleWidth(15),
                        vertical: context.scaleHeight(10),
                      ),

                      child: Text(
                        AppLocalizations.of(context)!.summary,

                        style: AppStyles.bold24White,
                      ),
                    ),


                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.scaleWidth(15),
                      ),

                      child: Text(
                        movie.descriptionFull ?? "",

                        style:
                        AppStyles.regular16lightGrey,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.scaleWidth(15),
                        vertical: context.scaleHeight(25),
                      ),

                      child: Text(
                        AppLocalizations.of(context)!.cast,

                        style: AppStyles.bold24White,
                      ),
                    ),


                    if (cast.isNotEmpty)
                      SizedBox(
                        height: context.scaleHeight(620),

                        child: ListView.separated(
                          padding: EdgeInsets.zero,

                          physics:
                          const NeverScrollableScrollPhysics(),

                          itemCount: cast.length,

                          separatorBuilder:
                              (context, index) {
                            return SizedBox(
                              height:
                              context.scaleHeight(10),
                            );
                          },

                          itemBuilder: (context, index) {
                            final currentCast = cast[index];

                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                context.scaleWidth(15),
                              ),

                              child: Container(
                                constraints:
                                BoxConstraints(
                                  minHeight:
                                  context.scaleHeight(140),
                                ),

                                padding: EdgeInsets.all(
                                  context.scaleWidth(15),
                                ),

                                decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(16),

                                  color:
                                  AppColors.darkGrayColor,
                                ),

                                child: Row(
                                  spacing:
                                  context.scaleWidth(15),

                                  children: [


                                    Container(
                                      width:
                                      context.scaleWidth(100),

                                      height:
                                      context.scaleHeight(100),

                                      decoration:
                                      BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(
                                          16,
                                        ),
                                      ),

                                      clipBehavior:
                                      Clip.antiAlias,

                                      child: currentCast
                                          .urlSmallImage !=
                                          null
                                          ? Image.network(
                                        currentCast
                                            .urlSmallImage!,

                                        fit: BoxFit.cover,

                                        errorBuilder:
                                            (context,
                                            error,
                                            stackTrace,) {
                                          return Image.asset(
                                            AppImages
                                                .film1917,

                                            fit: BoxFit.cover,
                                          );
                                        },
                                      )
                                          : Image.asset(
                                        AppImages.film1917,

                                        fit: BoxFit.cover,
                                      ),
                                    ),


                                    Expanded(
                                      child: Column(
                                        spacing:
                                        context.scaleHeight(
                                          10,
                                        ),

                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,

                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,

                                        children: [

                                          Text(
                                            "Name : ${currentCast.name ?? ""}",

                                            style: AppStyles
                                                .regular20White,

                                            maxLines: 2,

                                            overflow:
                                            TextOverflow
                                                .ellipsis,
                                          ),

                                          Text(
                                            "Character : ${currentCast
                                                .characterName ?? ""}",

                                            style: AppStyles
                                                .regular20White,

                                            maxLines: 2,

                                            overflow:
                                            TextOverflow
                                                .ellipsis,
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

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.scaleWidth(15),
                        vertical: context.scaleHeight(10),
                      ),

                      child: Text(
                        AppLocalizations.of(context)!
                            .genres,

                        style: AppStyles.bold24White,
                      ),
                    ),

                    if (genres.isNotEmpty)
                      Padding(
                        padding:
                        const EdgeInsets.all(15),

                        child: GridView.builder(
                          shrinkWrap: true,

                          padding: EdgeInsets.zero,

                          physics:
                          const NeverScrollableScrollPhysics(),

                          itemCount: genres.length,

                          itemBuilder:
                              (context, index) {
                            return Padding(
                              padding:
                              const EdgeInsets.all(3),

                              child: FilmInfoWidget(
                                horizontalPadding: 0,

                                data: genres[index],

                                style:
                                AppStyles.regular16White,

                                borderRadius: 12,
                              ),
                            );
                          },

                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,

                            childAspectRatio: 12 / 4,

                            crossAxisSpacing: 5,

                            mainAxisSpacing: 5,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }


          else {
            return MainLoadingWidget();
          }
        },
      ),
    );
  }
}


