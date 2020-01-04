import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:eshop/locator.dart';
import 'package:eshop/router.dart';
import 'package:eshop/services/crud.dart';
import 'package:eshop/utils/theme-data.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ));

    /*
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    */

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<Crud>()),
      ],
      child: MaterialApp(
        title: 'eShop',
        theme: themeData(),
        initialRoute: initialRoute,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
