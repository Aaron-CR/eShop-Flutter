import 'package:flutter/material.dart';

class AccountView extends StatelessWidget {
  const AccountView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Account',
        ),
      ),
      body: Container(
        child: Center(
          child: Container(
            child: Text('My Account'),
          ),
        ),
      ),
    );
  }
}
