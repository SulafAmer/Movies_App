import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/ui/screens/search_tab/cubit/search_cubit.dart';
import 'package:movies_app/ui/screens/search_tab/cubit/search_states.dart';
import 'package:movies_app/ui/widgets/film_poster_widget.dart';
import 'package:movies_app/ui/widgets/main_error_widget.dart';
import 'package:movies_app/ui/widgets/main_loading_widget.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_images.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/size_utils.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: const SearchTabView(),
    );
  }
}

class SearchTabView extends StatefulWidget {
  const SearchTabView({super.key});

  @override
  State<SearchTabView> createState() => _SearchTabViewState();
}

class _SearchTabViewState extends State<SearchTabView> {
  final TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final nearBottom =
        _scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200;
    if (nearBottom) {
      context.read<SearchCubit>().loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final searchCubit = context.read<SearchCubit>();

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
                          searchCubit.searchMovies(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: context.scaleHeight(24)),

              Expanded(
                child: BlocConsumer<SearchCubit, SearchState>(
                  listener: (context, state) {
                    if (state is SearchSuccess &&
                        !state.hasReachedMax &&
                        !state.isLoadingMore) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (!_scrollController.hasClients) return;
                        if (_scrollController.position.maxScrollExtent <= 0) {
                          context.read<SearchCubit>().loadMore();
                        }
                      });
                    }
                  },
                  builder: (context, state) {
                    if (state is SearchInitial) {
                      return _buildIdleState(context);
                    } else if (state is SearchLoading) {
                      return const Center(child: MainLoadingWidget());
                    } else if (state is SearchEmpty) {
                      return _buildEmptyResultState(context, loc);
                    } else if (state is SearchError) {
                      return Center(
                        child: MainErrorWidget(
                          errorMesaage: _mapErrorToMessage(loc, state.type),
                          onPressed: () {
                            searchCubit.searchMovies(searchController.text);
                          },
                        ),
                      );
                    } else if (state is SearchSuccess) {
                      return _buildResultsGrid(context, state);
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _mapErrorToMessage(AppLocalizations loc, SearchErrorType type) {
    switch (type) {
      case SearchErrorType.network:
        return loc.networkErrorMessage;
      case SearchErrorType.server:
        return loc.serverErrorMessage;
      case SearchErrorType.unknown:
        return loc.unknownErrorMessage;
    }
  }

  Widget _buildIdleState(BuildContext context) {
    return Center(child: Image.asset(AppImages.emptySearch));
  }

  Widget _buildEmptyResultState(BuildContext context, AppLocalizations loc) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(AppImages.emptySearch),
          SizedBox(height: context.scaleHeight(12)),
          Text(
            loc.noSearchResultsMessage,
            style: AppStyles.regular16White,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildResultsGrid(BuildContext context, SearchSuccess state) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            controller: _scrollController,
            itemCount: state.movies.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: context.scaleHeight(20),
              crossAxisSpacing: context.scaleWidth(20),
              childAspectRatio: 2 / 2.8,
            ),
            itemBuilder: (context, index) {
              final movie = state.movies[index];
              return FilmPosterWidget(
                filmId: movie.id,
                boxHeight: context.scaleHeight(279),
                boxWidth: context.scaleWidth(189),
                borderRadius: context.scaleWidth(16),
                filmImage: NetworkImage(movie.mediumCoverImage),
                filmRate: movie.rating.toString(),
              );
            },
          ),
        ),
        if (state.isLoadingMore)
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.scaleHeight(12)),
            child: const Center(
              child: SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
      ],
    );
  }
}
