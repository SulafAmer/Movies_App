import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/screens/browse_tab/cubit/browse_tab_states.dart';
import 'package:movies_app/ui/screens/browse_tab/cubit/browse_tab_view_model.dart';
import 'package:movies_app/ui/screens/browse_tab/tab_item_widget.dart';
import 'package:movies_app/ui/widgets/film_poster_widget.dart';
import 'package:movies_app/ui/widgets/main_error_widget.dart';
import 'package:movies_app/ui/widgets/main_loading_widget.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/size_utils.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  BrowseTabViewModel viewModel = BrowseTabViewModel();

  int selectedIndex = 0;
  String? selectedGenre;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        viewModel.getAllMovies();
        return viewModel;
      },
      child: BlocBuilder<BrowseTabViewModel, BrowseTabStates>(
        builder: (context, state) {

          if (state is BrowseTabLoadingState) {
            return MainLoadingWidget();
          }

          else if (state is BrowseTabErrorState) {
            return Center(
              child: MainErrorWidget(
                errorMesaage: state.errorMessage,
                onPressed: () {
                  viewModel.getAllMovies();
                },
              ),
            );
          }

          else if (state is BrowseTabSuccessState) {
            final movies = state.moviesResponse.data!.movies;

            final Set<String> genresSet = {};

            for (final movie in movies!) {
              genresSet.addAll(movie.genres ?? []);
            }

            final List<String> genres = genresSet.toList();

            if (selectedGenre == null && genres.isNotEmpty) {
              selectedGenre = genres.first;
              selectedIndex = 0;
            }

            final filteredMovies = movies.where((movie) {
              return movie.genres?.contains(selectedGenre) ?? false;
            }).toList();

            return Scaffold(
              backgroundColor: AppColors.blackColor,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    spacing: context.scaleHeight(20),
                    children: [


                      SizedBox(
                        height: context.scaleHeight(60),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: genres.length,

                          itemBuilder: (context, index) {
                            final genre = genres[index];

                            return InkWell(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  selectedGenre = genre;
                                });
                              },

                              child: TabItemWidget(
                                isSelected: selectedIndex == index,
                                text: genre,
                              ),
                            );
                          },

                          separatorBuilder: (context, index) {
                            return SizedBox(
                              width: context.scaleWidth(15),
                            );
                          },
                        ),
                      ),

                      Expanded(
                        child: GridView.builder(
                          itemCount: filteredMovies.length,

                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing:
                            context.scaleHeight(20),
                            crossAxisSpacing:
                            context.scaleWidth(20),
                            childAspectRatio: 2 / 2.8,
                          ),

                          itemBuilder: (context, index) {
                            final movie = filteredMovies[index];

                            return FilmPosterWidget(
                              filmId: movie.id!,
                              boxHeight: 279,
                              boxWidth: 189,
                              borderRadius: 16,
                              filmImage: NetworkImage(
                                movie.mediumCoverImage!,
                              ),
                              filmRate: "${movie.rating}",
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

          else {
            return MainLoadingWidget();
          }
        },
      ),
    );
  }
}