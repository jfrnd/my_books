// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:objectbox/objectbox.dart' as _i7;
import 'package:shared_preferences/shared_preferences.dart' as _i6;

import '../cubit/book_searcher_cubit.dart' as _i8;
import '../cubit/favorite_manager_cubit.dart' as _i10;
import '../data/local_book_data_source.dart' as _i9;
import '../data/remote_book_data_source.dart' as _i4;
import 'injectable_module.dart' as _i11;
import 'scroll_controller.dart' as _i5; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final injectableModule = _$InjectableModule();
  gh.factory<_i3.Client>(() => injectableModule.httpClient);
  gh.lazySingleton<_i4.IRemoteBookDataSource>(
      () => _i4.RemoteBookDataSource(get<_i3.Client>()));
  gh.factory<_i5.MyScrollController>(() => _i5.MyScrollController());
  await gh.factoryAsync<_i6.SharedPreferences>(() => injectableModule.prefs,
      preResolve: true);
  await gh.factoryAsync<_i7.Store>(() => injectableModule.store,
      preResolve: true);
  gh.factory<_i8.BookSearcherCubit>(() => _i8.BookSearcherCubit(
      get<_i4.IRemoteBookDataSource>(), get<_i6.SharedPreferences>()));
  gh.lazySingleton<_i9.ILocalBookDataSource>(
      () => _i9.LocalBookDataSource(get<_i7.Store>()));
  gh.factory<_i10.FavoriteManagerCubit>(
      () => _i10.FavoriteManagerCubit(get<_i9.ILocalBookDataSource>()));
  return get;
}

class _$InjectableModule extends _i11.InjectableModule {}
