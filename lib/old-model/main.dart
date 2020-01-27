import 'package:eshop/old-model/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:eshop/old-model/locator.dart';
import 'package:eshop/old-model/router.dart';
import 'package:eshop/old-model/services/crud.dart';
import 'package:eshop/old-model/utils/theme-data.dart';

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
        title: 'eshop/old-model',
        theme: themeData(),
        home: Wrapper(),
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
