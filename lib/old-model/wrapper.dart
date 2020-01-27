import 'package:eshop/old-model/screens/aTest.dart';
import 'package:eshop/old-model/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eshop/old-model/services/auth.dart';
import 'package:eshop/old-model/screens/authenticate_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AuthService.instance(),
      child: Consumer(
        builder: (context, AuthService user, _) {
          print(user.status);
          switch (user.status) {
            // TODO: not showing SplashScreen correctly
            case Status.Uninitialized:
              return SplashScreen();
            case Status.Unauthenticated:
            case Status.Authenticating:
              return AuthenticateScreen();
            case Status.Authenticated:
              return Test();
          }
          return null;
        },
      ),
    );
  }
}
