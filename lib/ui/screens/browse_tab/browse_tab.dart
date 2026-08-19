import 'package:flutter/material.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/ui/screens/browse_tab/tab_item_widget.dart';
import 'package:movies_app/ui/widgets/film_poster_widget.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/size_utils.dart';

class BrowseTab extends StatefulWidget {
  BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  int selectedIndex = 0;
  List<int> tabItemsNum = [2, 3, 5, 10, 1, 4, 7, 2];

  @override
  Widget build(BuildContext context) {
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
                        setState(() {});
                      },
                      child: TabItemWidget(
                        isSelected: selectedIndex == index,
                        text: AppLocalizations.of(context)!.action,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: context.scaleWidth(15));
                  },
                  itemCount: 7,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: tabItemsNum[selectedIndex],

                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: context.scaleHeight(20),
                    crossAxisSpacing: context.scaleWidth(20),
                    childAspectRatio: 2 / 2.8,
                  ),
                  itemBuilder: (context, index) {
                    return FilmPosterWidget(
                      boxHeight: 279,
                      boxWidth: 189,
                      borderRadius: 16,
                      filmImage: AppImages.blackWidowFilm,
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
