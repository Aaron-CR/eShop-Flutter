import 'package:get_it/get_it.dart';
import 'package:eshop/core/services/navigation_service.dart';
import 'package:eshop/core/services/dialog_service.dart';
import 'package:eshop/core/services/authentication_service.dart';
import 'package:eshop/core/services/firestore_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());
}
