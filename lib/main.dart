import 'package:eshop/locator.dart';
import 'package:eshop/services/crud.dart';
import 'package:eshop/widgets/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eshop/router.dart';
import 'package:eshop/wrapper.dart';
import 'package:eshop/utils/theme-data.dart';
import 'package:provider/provider.dart';

/* void main() {
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      theme: themeData(),
      home: Wrapper(),
      routes: routes,
    );
  }
} */

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<Crud>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        title: 'Product App',
        theme: themeData(),
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}