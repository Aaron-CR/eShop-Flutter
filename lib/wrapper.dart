import 'package:eshop/screens/authenticate/login_page.dart';
import 'package:eshop/screens/authenticate/sign_in_screen.dart';
import 'package:eshop/screens/home.dart';
import 'package:eshop/services/auth.dart';
import 'package:eshop/shared/constants.dart';
import 'package:eshop/shared/constants_routes.dart';
import 'package:eshop/utils/spinner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              return Splash();
            case Status.Unauthenticated:
              return SignInScreen();
            case Status.Authenticating:
              return Spinner();
            case Status.Authenticated:
              return Home(user: user.user);
          }
          return null;
        },
      ),
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: kMainColor,
      child: Center(
        child: Text(
          "Splash Screen",
          style: kLabelStyle,
        ),
      ),
    );
  }
}
