import 'package:eshop/old-model/shared/constants.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kMainColor,
      child: Center(
        child: Image.asset(
          "assets/images/launch_image.png",
          height: MediaQuery.of(context).size.height * 0.13,
        ),
      ),
    );
  }
}
