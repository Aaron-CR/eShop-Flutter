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
        body: ListView(
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.all(12.0),
              leading: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(model.currentUser.photoURL),
                  backgroundColor: Colors.grey[300],
                ),
              ),
              title: Text(
                model.currentUser.displayName,
                style: textTheme.title,
              ),
              subtitle: Text(model.currentUser.email),
            ),
          ],
        ),
      ),
    );
  }
}
