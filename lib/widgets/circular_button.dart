import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  const CircularButton(
      {Key key, @required this.onPressed, @required this.image, this.color})
      : super(key: key);

  final Function onPressed;
  final String image;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      child: Image.asset(
        image,
        height: 24.0,
      ),
      shape: CircleBorder(),
      elevation: 2.0,
      fillColor: color == null ? Colors.white : color,
      padding: EdgeInsets.all(16.0),
    );
  }
}
