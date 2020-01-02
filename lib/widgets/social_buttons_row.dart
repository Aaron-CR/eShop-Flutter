import 'package:flutter/material.dart';

import 'circular_button.dart';

class SocialButtonsRow extends StatelessWidget {
  const SocialButtonsRow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularButton(
              onPressed: () {},
              image: 'assets/images/facebook-logo.png',
              color: Color(0xFF4267B2)),
          SizedBox(width: 10.0),
          CircularButton(
            onPressed: () {},
            image: 'assets/images/google-logo.png',
          ),
        ],
      ),
    );
  }
}
