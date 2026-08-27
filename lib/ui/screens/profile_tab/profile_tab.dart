import 'package:flutter/material.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/ui/widgets/film_poster_widget.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                context.scaleWidth(16),
                context.scaleHeight(38),
                context.scaleWidth(16),
                0,
              ),
              child: Column(
                children: [
                  _buildProfileHeader(localizations),
                  SizedBox(height: context.scaleHeight(22)),
                  _buildActionButtons(localizations),
                ],
              ),
            ),
            SizedBox(height: context.scaleHeight(18)),
            _buildTabs(localizations),
            Expanded(
              child: selectedTabIndex == 0
                  ? _buildEmptyWatchList()
                  : _buildHistoryGrid(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(AppLocalizations localizations) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: context.scaleHeight(130),
          child: Column(
            children: [
              ClipOval(
                child: Image.asset(
                  AppImages.avatar2,
                  width: context.scaleHeight(118),
                  height: context.scaleHeight(118),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: context.scaleHeight(10)),
              Text(
                'John Safwat',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.bold20White,
              ),
            ],
          ),
        ),
        SizedBox(width: context.scaleWidth(40)),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: context.scaleHeight(35)),
            child: Row(
              children: [
                Expanded(
                  child: _buildStat(value: '12', label: localizations.wishList),
                ),
                Container(
                  width: 1,
                  height: context.scaleHeight(62),
                  color: Colors.white24,
                ),
                Expanded(
                  child: _buildStat(value: '10', label: localizations.history),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStat({required String value, required String label}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value, style: AppStyles.medium36White),
        SizedBox(height: context.scaleHeight(6)),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppStyles.bold20White,
        ),
      ],
    );
  }

  Widget _buildActionButtons(AppLocalizations localizations) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: SizedBox(
            height: context.scaleHeight(55),
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                    AppRoutes.updateProfileScreenRouteName);
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: AppColors.yellowColor,
                foregroundColor: AppColors.blackColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                localizations.editProfile,
                style: AppStyles.regular20Black,
              ),
            ),
          ),
        ),
        SizedBox(width: context.scaleWidth(10)),
        Expanded(
          child: SizedBox(
            height: context.scaleHeight(55),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: EdgeInsets.symmetric(
                  horizontal: context.scaleWidth(10),
                ),
                backgroundColor: AppColors.redColor,
                foregroundColor: AppColors.whiteColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      localizations.exit,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.regular20White,
                    ),
                  ),
                  SizedBox(width: context.scaleWidth(7)),
                  Icon(
                    Icons.logout,
                    size: context.scaleWidth(22),
                    color: AppColors.whiteColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabs(AppLocalizations localizations) {
    return Row(
      children: [
        _buildTab(
          index: 0,
          icon: Icons.format_list_bulleted_rounded,
          label: localizations.watchList,
        ),
        _buildTab(
          index: 1,
          icon: Icons.folder_rounded,
          label: localizations.history,
        ),
      ],
    );
  }

  Widget _buildTab({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = selectedTabIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => selectedTabIndex = index),
        child: Container(
          height: context.scaleHeight(84),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? AppColors.yellowColor : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: context.scaleHeight(34),
                color: AppColors.yellowColor,
              ),
              SizedBox(height: context.scaleHeight(6)),
              Text(label, style: AppStyles.regular20White),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyWatchList() {
    return Padding(
      padding: EdgeInsets.only(bottom: context.scaleHeight(105)),
      child: Center(
        child: Image.asset(
          AppImages.emptyProfile,
          width: context.scaleHeight(125),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildHistoryGrid() {
    return GridView.builder(
      padding: EdgeInsets.fromLTRB(
        context.scaleWidth(16),
        context.scaleHeight(26),
        context.scaleWidth(16),
        context.scaleHeight(125),
      ),
      itemCount: 10,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: context.scaleHeight(16),
        crossAxisSpacing: context.scaleWidth(16),
        childAspectRatio: 116 / 180,
      ),
      itemBuilder: (context, index) {
        return FilmPosterWidget(
          filmId: 0,
          boxHeight: 180,
          boxWidth: 116,
          borderRadius: 12,
          filmImage: AssetImage(index.isEven
              ? AppImages.blackWidowFilm
              : AppImages.film1917),
          filmRate: '7.7',
        );
      },
    );
  }
}
