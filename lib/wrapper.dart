import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eshop/services/auth.dart';
import 'package:eshop/shared/constants.dart';
import 'package:eshop/utils/spinner.dart';
import 'package:eshop/screens/home.dart';
import 'package:eshop/screens/authenticate.dart';

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
              return AuthenticateScreen();
            case Status.Authenticating:
              return Spinner();
            case Status.Authenticated:
              return Home();
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
