import 'package:eshop/screens/splash_screen.dart';
import 'package:eshop/widgets/spinner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eshop/services/auth.dart';
import 'package:eshop/screens/home_screen.dart';
import 'package:eshop/screens/authenticate_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AuthService.instance(),
      child: Consumer(
        builder: (context, AuthService user, _) {
          switch (user.status) {
            case Status.Uninitialized:
              return SplashScreen();
            case Status.Unauthenticated:
              return AuthenticateScreen();
            case Status.Authenticating:
              return Spinner();
            case Status.Authenticated:
              return HomeScreen();
          }
          return null;
        },
      ),
    );
  }
}
