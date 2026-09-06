import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/ui/screens/profile_tab/profile_screen/cubit/profile_cubit.dart';
import 'package:movies_app/ui/widgets/film_poster_widget.dart';
import 'package:movies_app/ui/widgets/main_loading_widget.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_routes.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';
import 'package:movies_app/api/models/movie.dart';
import '../history_list/cubit/history_list_cubit.dart';
import '../history_list/cubit/history_list_states.dart';
import '../watch_list/cubit/watch_list_cubit.dart';
import '../watch_list/cubit/watch_list_states.dart';
import 'cubit/profile_states.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<WatchListCubit>().loadWatchList();
    context.read<HistoryCubit>().loadHistory();
    final currentUserId=FirebaseAuth.instance.currentUser?.uid??'';
    context.read<ProfileCubit>().loadUserProfile(currentUserId);
  }

  @override
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final watchListCount = context.select<WatchListCubit, int>((cubit) {
      final state = cubit.state;
      if (state is WatchListSuccessState) {
        return state.moviesList.length;
      }
      return 0;
    });

    final historyCount = context.select<HistoryCubit, int>((cubit) {
      final state = cubit.state;
      if (state is HistorySuccessState) {
        return state.moviesList.length;
      }
      return 0;
    });

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: MainLoadingWidget());
            } else if (state is ProfileError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 60),
                    const SizedBox(height: 16),
                    Text(state.message, style: const TextStyle(color: Colors.white, fontSize: 18)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        if (!context.mounted) return;
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.loginScreenRouteName, (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.redColor),
                      child: Text(localizations.exit),
                    )
                  ],
                ),
              );
            } else if (state is ProfileLoaded) {
              return Column(
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
                        // 🔹 نمرر أرقام العدادات هنا للدالة الفرعية
                        _buildProfileHeader(
                          localizations: localizations,
                          user: state.user,
                          watchListCount: watchListCount,
                          historyCount: historyCount,
                        ),
                        SizedBox(height: context.scaleHeight(22)),
                        _buildActionButtons(localizations),
                      ],
                    ),
                  ),
                  SizedBox(height: context.scaleHeight(18)),
                  _buildTabs(localizations),
                  Expanded(
                    child: selectedTabIndex == 0
                        ? _buildWatchListTab()
                        : _buildHistoryGrid(),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildProfileHeader({
    required AppLocalizations localizations,
    required var user,
    required int watchListCount,
    required int historyCount,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: context.scaleHeight(130),
          child: Column(
            children: [
              ClipOval(
                child: Image.asset(
                  user.avatar,
                  width: context.scaleHeight(118),
                  height: context.scaleHeight(118),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: context.scaleHeight(10)),
              Text(
                user.name ?? 'No Name',
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
            padding: EdgeInsets.only(
              top: context.scaleHeight(35),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildStat(
                    value: watchListCount.toString(),
                    label: localizations.wishList,
                  ),
                ),
                Container(
                  width: 1,
                  height: context.scaleHeight(62),
                  color: Colors.white24,
                ),
                Expanded(
                  child: _buildStat(
                    value: historyCount.toString(),
                    label: localizations.history,
                  ),
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
              onPressed: () async {
                await Navigator.of(context).pushNamed(AppRoutes.updateProfileScreenRouteName);

                final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
                if (mounted) {
                  context.read<ProfileCubit>().loadUserProfile(currentUserId);
                }
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
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                if (!context.mounted) return;
                Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.loginScreenRouteName,
                      (route) => false,
                );
              },
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

  Widget _buildWatchListTab() {
    return BlocBuilder<WatchListCubit, WatchListStates>(
      builder: (context, state) {
        if (state is WatchListLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is WatchListErrorState) {
          return Center(
            child: Text(state.errorMessage, style: AppStyles.regular20White),
          );
        }

        if (state is WatchListSuccessState) {
          if (state.moviesList.isEmpty) {
            return _buildEmptyWatchList();
          }
          return _buildWatchListGrid(state.moviesList);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildWatchListGrid(List<Movie> movies) {
    return GridView.builder(
      padding: EdgeInsets.fromLTRB(
        context.scaleWidth(16),
        context.scaleHeight(26),
        context.scaleWidth(16),
        context.scaleHeight(125),
      ),
      itemCount: movies.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: context.scaleHeight(16),
        crossAxisSpacing: context.scaleWidth(16),
        childAspectRatio: 116 / 180,
      ),
      itemBuilder: (context, index) {
        final movie = movies[index];
        return FilmPosterWidget(
          filmId: movie.id,
          boxHeight: 180,
          boxWidth: 116,
          borderRadius: 12,
          filmImage: NetworkImage(movie.mediumCoverImage),
          filmRate: movie.rating.toString(),
        );
      },
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
    return BlocBuilder<HistoryCubit, HistoryStates>(
      builder: (context, state) {

        if (state is HistoryLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is HistoryErrorState) {
          return Center(
            child: Text(
              state.errorMessage,
              style: AppStyles.regular20White,
            ),
          );
        }

        if (state is HistorySuccessState) {
          if (state.moviesList.isEmpty) {
            return _buildEmptyWatchList();
          }

          return _buildHistoryMoviesGrid(state.moviesList);
        }

        return const SizedBox.shrink();
      },
    );
  }
  Widget _buildHistoryMoviesGrid(List<Movie> movies) {
    return GridView.builder(
      padding: EdgeInsets.fromLTRB(
        context.scaleWidth(16),
        context.scaleHeight(26),
        context.scaleWidth(16),
        context.scaleHeight(125),
      ),
      itemCount: movies.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: context.scaleHeight(16),
        crossAxisSpacing: context.scaleWidth(16),
        childAspectRatio: 116 / 180,
      ),
      itemBuilder: (context, index) {
        final movie = movies[index];

        return FilmPosterWidget(
          filmId: movie.id,
          boxHeight: 180,
          boxWidth: 116,
          borderRadius: 12,
          filmImage: NetworkImage(movie.mediumCoverImage),
          filmRate: movie.rating.toString(),
        );
      },
    );
  }
}