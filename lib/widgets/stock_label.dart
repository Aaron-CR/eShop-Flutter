import 'package:flutter/material.dart';

class StockLabel extends StatelessWidget {
  final Color color;
  final String text;
  const StockLabel({
    Key key,
    this.color,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        // Change icon on OUT STOCK Icons.indeterminate_check_box,
        Icon(
          Icons.check_box,
          color: color,
        ),
        Text(
          text,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
