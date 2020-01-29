import 'package:flutter/material.dart';
import 'package:eshop/shared/app_colors.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({Key key, @required this.onPressed, @required this.text})
      : super(key: key);

  final Function onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: onPressed,
        padding: EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: kMainColor,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.1,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
}
