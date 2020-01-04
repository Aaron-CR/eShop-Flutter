import 'package:eshop/shared/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
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
