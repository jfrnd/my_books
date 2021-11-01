import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';

import 'injection.config.dart';


final GetIt getIt = GetIt.instance;

@injectableInit
Future<void> configureInjection(String env) async {
  await $initGetIt(getIt, environment: env);
}