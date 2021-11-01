import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:objectbox/objectbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kleine_aufgabe/objectbox.g.dart';

@module
abstract class InjectableModule {
  @preResolve
  Future<SharedPreferences> get prefs async =>
      await SharedPreferences.getInstance();
  @preResolve
  Future<Store> get store async => await openStore();

  Client get httpClient => Client();
}
