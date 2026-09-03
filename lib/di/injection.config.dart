// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:movies_app/ui/screens/profile_tab/history_list/cubit/history_list_cubit.dart'
    as _i94;
import 'package:movies_app/ui/screens/profile_tab/watch_list/cubit/watch_list_cubit.dart'
    as _i434;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i94.HistoryCubit>(() => _i94.HistoryCubit());
    gh.lazySingleton<_i434.WatchListCubit>(() => _i434.WatchListCubit());
    return this;
  }
}
