import 'package:flutter/material.dart';

class DealsScreen extends StatelessWidget {
  const DealsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Deals',
        ),
      ),
      body: Container(
          child: Center(
        child: Container(
          child: Text('Deals'),
        ),
      )),
    );
  }
}
