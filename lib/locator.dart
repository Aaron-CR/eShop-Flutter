import 'package:eshop/services/api.dart';
import 'package:eshop/services/crud.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api('products'));
  locator.registerLazySingleton(() => Crud());
}
