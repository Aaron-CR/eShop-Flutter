import 'package:eshop/shared/shared_styles.dart';
import 'package:eshop/shared/ui_helpers.dart';
import 'package:eshop/theme/theme.dart';
import 'package:eshop/widgets/background.dart';
import 'package:flutter/material.dart';

class AccountView extends StatelessWidget {
  const AccountView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.1,
        title: Text(
          'My Account',
        ),
      ),
      body: Container(
        child: Container(
          color: Colors.red,
          height: screenHeightFraction(context, dividedBy: 2),
          child: Stack(
            children: <Widget>[
              Background(),
              Padding(
                padding: EdgeInsets.all(18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    verticalSpaceLarge,
                    CircleAvatar(
                      radius: 35.0,
                      backgroundImage:
                          AssetImage('assets/images/user/user-thumb.jpg'),
                      backgroundColor: Colors.grey[50],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'User Name',
                          style: textTheme.display1.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        verticalSpaceTiny,
                        Text(
                          'User Email',
                          style: textTheme.subtitle.copyWith(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
