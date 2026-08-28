import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/ui/screens/movie_details/cubit/movie_suggestion_states.dart';
import 'package:movies_app/ui/screens/movie_details/cubit/movie_suggestion_view_model.dart';
import 'package:movies_app/ui/widgets/film_poster_widget.dart';
import 'package:movies_app/ui/widgets/main_error_widget.dart';
import 'package:movies_app/ui/widgets/main_loading_widget.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class MovieSuggestion extends StatefulWidget {
  MovieSuggestion({
    super.key,
    required this.filmId,
  });

  int filmId;

  @override
  State<MovieSuggestion> createState() => _MovieSuggestionState();
}

class _MovieSuggestionState extends State<MovieSuggestion> {
  MovieSuggestionViewModel viewModel = MovieSuggestionViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        viewModel.getMovieSuggestions(widget.filmId);
        return viewModel;
      },

      child: BlocBuilder<
          MovieSuggestionViewModel,
          MovieSuggestionStates>(
        builder: (context, state) {
          if (state is MovieSuggestionLoadingState) {
            return MainLoadingWidget();
          }


          else if (state is MovieSuggestionErrorState) {
            return MainErrorWidget(
              errorMesaage: state.errorMessage,
              onPressed: () {
                viewModel.getMovieSuggestions(widget.filmId);
              },
            );
          }


          else if (state is MovieSuggestionSuccessState) {
            final movies =
                state.movieSuggestion.data?.movies;

            if (movies != null && movies.isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.scaleWidth(15),
                      vertical: context.scaleHeight(10),
                    ),

                    child: Text(
                      AppLocalizations.of(context)!.similar,
                      style: AppStyles.bold24White,
                    ),
                  ),


                  Padding(
                    padding: EdgeInsets.all(
                      context.scaleWidth(15),
                    ),

                    child: SizedBox(
                      height: context.scaleHeight(500),

                      child: GridView.builder(
                        padding: EdgeInsets.zero,

                        physics:
                        const NeverScrollableScrollPhysics(),

                        itemCount: movies.length,

                        itemBuilder: (context, index) {
                          final movie = movies[index];

                          return FilmPosterWidget(
                            filmId: movie.id!,

                            boxHeight: 500,

                            boxWidth: 189,

                            borderRadius: 16,

                            filmImage: NetworkImage(
                              movie.mediumCoverImage!,
                            ),

                            filmRate:
                            "${movie.rating!}",

                            horizontalMargin:
                            context.scaleWidth(15),

                            verticaMargin:
                            context.scaleWidth(10),
                          );
                        },

                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,

                          childAspectRatio: 12 / 15,

                          crossAxisSpacing:
                          context.scaleWidth(25),

                          mainAxisSpacing:
                          context.scaleHeight(15),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const SizedBox.shrink();
            }
          }


          else {
            return MainLoadingWidget();
          }
        },
      ),
    );
  }
}
