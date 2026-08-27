import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/ui/widgets/film_poster_widget.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class SearchTab extends StatefulWidget {
  const SearchTab({super.key});

  @override
  State<SearchTab> createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  final TextEditingController searchController = TextEditingController();
  bool hasQuery = false;

  final int mockResultsCount = 6;

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.scaleWidth(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.scaleHeight(16)),

              Container(
                height: context.scaleHeight(52),
                padding: EdgeInsets.symmetric(
                  horizontal: context.scaleWidth(16),
                ),
                decoration: BoxDecoration(
                  color: AppColors.darkGrayColor,
                  borderRadius: BorderRadius.circular(context.scaleWidth(30)),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.searchIcon,
                      width: context.scaleWidth(20),
                      height: context.scaleWidth(20),
                      colorFilter: ColorFilter.mode(
                        AppColors.whiteColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: context.scaleWidth(12)),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        style: AppStyles.regular16White,
                        decoration: InputDecoration(
                          hintText: loc.searchHint,
                          hintStyle: AppStyles.regular16White,
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() => hasQuery = value.trim().isNotEmpty);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.scaleHeight(24)),

              Expanded(
                child: hasQuery
                    ? _buildResultsGrid(context)
                    : _buildEmptyState(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(child: Image.asset(AppImages.emptySearch));
  }

  Widget _buildResultsGrid(BuildContext context) {
    return GridView.builder(
      itemCount: mockResultsCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: context.scaleHeight(20),
        crossAxisSpacing: context.scaleWidth(20),
        childAspectRatio: 2 / 2.8,
      ),
      itemBuilder: (context, index) {
        return FilmPosterWidget(
          filmId: 0,
          boxHeight: 279,
          boxWidth: 189,
          borderRadius: 16,
          filmImage: AppImages.blackWidowFilm,
          filmRate: "7.7",
        );
      },
    );
  }
}
