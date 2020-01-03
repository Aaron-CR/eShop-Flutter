import 'package:eshop/services/auth.dart';
import 'package:flutter/material.dart';

import 'circular_button.dart';

class SocialButtonsRow extends StatelessWidget {
  const SocialButtonsRow({
    Key key,
    @required this.user,
    @required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final AuthService user;
  final GlobalKey<ScaffoldState> _scaffoldKey;

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
            onPressed: () async {
              if (!await user.signInWithGoogle())
                _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text("Something is wrong"),
                ));
            },
            image: 'assets/images/google-logo.png',
          ),
        ],
      ),
    );
  }
}
