import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/ui/screens/browse_tab/cubit/browse_tab_states.dart';
import 'package:movies_app/ui/screens/browse_tab/cubit/browse_tab_view_model.dart';
import 'package:movies_app/ui/screens/browse_tab/tab_item_widget.dart';
import 'package:movies_app/ui/widgets/film_poster_widget.dart';
import 'package:movies_app/ui/widgets/main_error_widget.dart';
import 'package:movies_app/ui/widgets/main_loading_widget.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/size_utils.dart';

class BrowseTab extends StatefulWidget {
  BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  BrowseTabViewModel viewModel = BrowseTabViewModel();

  int selectedIndex = 0;
  List<String> genres = [
    "Drama",
    "Crime",
    "Documentary",
    "Mystery",
    "Horror",
    "Romance",
    "Comedy",
    "Thriller",
    "Action",
    "Sci-Fi",
    "Family",
    "Music",
    "Adventure"
  ];
  late String selectedGenre = genres[selectedIndex];

  @override
  Widget build(BuildContext context) {
    List<String> localizationGenres = [
      AppLocalizations.of(context)!.drama,
      AppLocalizations.of(context)!.crime,
      AppLocalizations.of(context)!.documentary,
      AppLocalizations.of(context)!.mystery,
      AppLocalizations.of(context)!.horror,
      AppLocalizations.of(context)!.romance,
      AppLocalizations.of(context)!.comedy,
      AppLocalizations.of(context)!.thriller,
      AppLocalizations.of(context)!.action,
      AppLocalizations.of(context)!.sci_fi,
      AppLocalizations.of(context)!.family,
      AppLocalizations.of(context)!.music,
      AppLocalizations.of(context)!.adventure,
    ];


    return BlocProvider(
      create: (context) {
        viewModel.getMoviesByCategory(selectedGenre);
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
                  viewModel.getMoviesByCategory(selectedGenre);
                },
              ),
            );
          }


          else if (state is BrowseTabSuccessState) {
            final movies = state.browseResponse.data!.movies;

            return Scaffold(
              backgroundColor: AppColors.blackColor,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    spacing: context.scaleHeight(20),
                    children: [
                      Container(
                        height: context.scaleHeight(60),
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                selectedIndex = index;
                                selectedGenre = genres[selectedIndex];
                                setState(() {});
                                viewModel.getMoviesByCategory(selectedGenre);
                              },
                              child: TabItemWidget(
                                isSelected: selectedIndex == index,
                                text: localizationGenres[index],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(width: context.scaleWidth(15));
                          },
                          itemCount: genres.length,
                        ),
                      ),
                      Expanded(
                        child: GridView.builder(
                          itemCount: movies!.length,

                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: context.scaleHeight(20),
                            crossAxisSpacing: context.scaleWidth(20),
                            childAspectRatio: 2 / 2.8,
                          ),
                          itemBuilder: (context, index) {
                            return FilmPosterWidget(
                              filmId: movies[index].id!,
                              boxHeight: 279,
                              boxWidth: 189,
                              borderRadius: 16,
                              filmImage: NetworkImage(
                                  movies[index].mediumCoverImage!),
                              filmRate: "${movies[index].rating}",
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
