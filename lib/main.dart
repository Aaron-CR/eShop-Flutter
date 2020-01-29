import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eshop/core/locator.dart';
import 'package:eshop/core/managers/dialog_manager.dart';
import 'package:eshop/core/services/navigation_service.dart';
import 'package:eshop/core/services/dialog_service.dart';
import 'package:eshop/views/startup/startup_view.dart';
import 'package:eshop/theme/theme.dart';
import 'package:eshop/router.dart';

void main() {
  // Register all the models and services before the app starts
  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /* SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    )); */

    return MaterialApp(
      title: 'eShop',
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      theme: themeData,
      home: StartUpView(),
      onGenerateRoute: generateRoute,
    );
  }
}
