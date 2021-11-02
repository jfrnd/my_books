// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:http/http.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;
import 'package:objectbox/objectbox.dart' as _i6;
import 'package:shared_preferences/shared_preferences.dart' as _i5;

import '../cubit/book_searcher_cubit.dart' as _i7;
import '../cubit/favorite_manager_cubit.dart' as _i9;
import '../data/local_book_data_source.dart' as _i8;
import '../data/remote_book_data_source.dart' as _i4;
import 'injectable_module.dart' as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final injectableModule = _$InjectableModule();
  gh.factory<_i3.Client>(() => injectableModule.httpClient);
  gh.lazySingleton<_i4.IRemoteBookDataSource>(
      () => _i4.RemoteBookDataSource(get<_i3.Client>()));
  await gh.factoryAsync<_i5.SharedPreferences>(() => injectableModule.prefs,
      preResolve: true);
  await gh.factoryAsync<_i6.Store>(() => injectableModule.store,
      preResolve: true);
  gh.factory<_i7.BookSearcherCubit>(
      () => _i7.BookSearcherCubit(get<_i4.IRemoteBookDataSource>()));
  gh.lazySingleton<_i8.ILocalBookDataSource>(
      () => _i8.LocalBookDataSource(get<_i6.Store>()));
  gh.factory<_i9.FavoriteManagerCubit>(
      () => _i9.FavoriteManagerCubit(get<_i8.ILocalBookDataSource>()));
  return get;
}

class _$InjectableModule extends _i10.InjectableModule {}
