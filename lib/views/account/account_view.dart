import 'package:eshop/shared/shared_styles.dart';
import 'package:eshop/shared/ui_helpers.dart';
import 'package:eshop/theme/theme.dart';
import 'package:eshop/views/account/account_view_model.dart';
import 'package:eshop/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class AccountView extends StatelessWidget {
  const AccountView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<AccountViewModel>.withConsumer(
      viewModel: AccountViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'My Account',
          ),
        ),
        body: Container(
          child: Container(
            color: Colors.red,
            height: screenHeightFraction(context, dividedBy: 2.5),
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
                            NetworkImage(model.currentUser.photoURL),
                        backgroundColor: Colors.grey[50],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            model.currentUser.displayName,
                            style: textTheme.display1.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          verticalSpaceTiny,
                          Text(
                            model.currentUser.email,
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
      ),
    );
  }
}
