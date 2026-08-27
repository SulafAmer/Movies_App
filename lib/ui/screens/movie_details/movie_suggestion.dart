import 'package:flutter/material.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/ui/widgets/film_poster_widget.dart';
import 'package:movies_app/ui/widgets/main_error_widget.dart';
import 'package:movies_app/ui/widgets/main_loading_widget.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class MovieSuggestion extends StatelessWidget {
  MovieSuggestion({super.key, required this.filmId});

  int filmId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getMovieSuggestion(id: filmId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MainLoadingWidget();
        } else if (snapshot.hasError) {
          print(snapshot.error);
          return Scaffold(
            backgroundColor: Colors.white,
            body: MainErrorWidget(errorMesaage: "error", onPressed: () {}),
          );
        } else {
          var movies = snapshot.data?.data?.movies;
          if (movies != null) {
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
                  padding: EdgeInsets.all(context.scaleWidth(15)),
                  child: Container(
                    height: context.scaleHeight(500),
                    child: GridView.builder(
                      padding: EdgeInsets.all(0),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: movies!.length,
                      itemBuilder: (context, index) {
                        return FilmPosterWidget(
                          filmId: movies[index].id!,
                          boxHeight: 500,
                          boxWidth: 189,
                          borderRadius: 16,
                          filmImage: NetworkImage(
                              movies[index].mediumCoverImage!),
                          filmRate: "${movies[index].rating!}",
                          horizontalMargin: context.scaleWidth(15),
                          verticaMargin: context.scaleWidth(10),
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 12 / 15,
                        crossAxisSpacing: context.scaleWidth(25),
                        mainAxisSpacing: context.scaleHeight(15),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        }
      },
    );
  }
}
