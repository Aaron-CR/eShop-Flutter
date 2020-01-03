import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eshop/router.dart';
import 'package:eshop/wrapper.dart';
import 'package:eshop/utils/theme-data.dart';

void main() => runApp(MyApp());

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
}
