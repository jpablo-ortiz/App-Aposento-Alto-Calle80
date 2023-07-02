import 'package:app_aposento_alto_calle80/services/repositories/authentication_repository.dart';
import 'package:app_aposento_alto_calle80/services/repositories/member_repository.dart';
import 'package:app_aposento_alto_calle80/services/repositories/preferences_repository.dart';
import 'package:app_aposento_alto_calle80/services/repositories/storage_repository.dart';
import 'package:app_aposento_alto_calle80/utils/image_selector.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void setupInjector() {
  getIt.registerSingleton<AuthenticationRepository>(AuthenticationRepositoryImpl());
  getIt.registerSingleton<PreferencesRepository>(PreferencesRepositoryImpl());
  getIt.registerLazySingleton<StorageRepository>(() => StorageRepositoryImpl());
  getIt.registerLazySingleton<MemberRepository>(() => MemberRepositoryImpl());
  getIt.registerLazySingleton<ImageSelector>(() => ImageSelector());
}
