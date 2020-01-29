import 'package:flutter/material.dart';

class DealsView extends StatelessWidget {
  const DealsView({Key key}) : super(key: key);

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
