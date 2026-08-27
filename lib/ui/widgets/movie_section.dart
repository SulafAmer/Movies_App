import 'package:flutter/material.dart';

import '../../api/models/movies.dart';
import '../../l10n/app_localizations.dart';
import '../../utils/app_styles.dart';
import '../../utils/size_utils.dart';
import 'film_poster_widget.dart';

class MovieSection extends StatelessWidget {
  final String title;
  final List<Movie> movies;

  const MovieSection({
    super.key,
    required this.title,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: context.scaleWidth(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppStyles.regular20White,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  AppLocalizations.of(context)!.see_more,
                  style: AppStyles.regular16Yellow,
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: context.scaleHeight(220),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            separatorBuilder: (context, index) {
              return SizedBox(
                width: context.scaleWidth(9),
              );
            },
            itemBuilder: (context, index) {
              final movie = movies[index];

              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.scaleWidth(8),
                ),
                child: FilmPosterWidget(
                  filmId: movie.id,
                  borderRadius: 20,
                  boxHeight: 220,
                  boxWidth: 150,
                  filmImage: movie.mediumCoverImage,
                  filmRate: movie.rating.toString(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}