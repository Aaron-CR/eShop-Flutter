import 'package:eshop/utils/theme-data.dart';
import 'package:eshop/wrapper.dart';
import 'package:eshop/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';
import 'package:eshop/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    ));

    return MaterialApp(
      theme: themeData(),
      home: Wrapper(),
      routes: routes,
    );
  }
}
