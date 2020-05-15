import 'package:app/services/api.dart';
import 'package:app/services/httpApi.dart';
import 'package:app/services/jsonApi.dart';

import 'package:get_it/get_it.dart';

/* This allows us to create a fake api if we wish */

GetIt locator = GetIt.instance;

const bool USE_FAKE_API = true;

void setupLocator() {
  // Currently just return httpApi cause im too lazy but might come in handy
  locator.registerLazySingleton<Api>(() => USE_FAKE_API ? JsonApi() : HttpApi());
}


