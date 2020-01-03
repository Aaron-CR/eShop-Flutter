import 'package:eshop/services/auth.dart';
import 'package:eshop/shared/constants_routes.dart';
import 'package:eshop/utils/spinner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('eShop'),
        centerTitle: true,
      ),
      drawer: FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (BuildContext context, AsyncSnapshot user) {
          return user.hasData ? buildDrawer(context, user) : Spinner();
        },
      ),
      body: Center(
        child: Container(
          child: Text('Home'),
        ),
      ),
    );
  }

  Drawer buildDrawer(BuildContext context, AsyncSnapshot user) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  onDetailsPressed: () {
                    Navigator.of(context).popAndPushNamed(profileRoute);
                  },
                  accountName: Text(
                    user.data.displayName.toString(),
                    style: TextStyle(color: Colors.black),
                  ),
                  accountEmail: Text(
                    user.data.email.toString(),
                    style: TextStyle(color: Colors.black),
                  ),
                  decoration: BoxDecoration(color: Colors.grey[50]),
                  currentAccountPicture: GestureDetector(
                    onTap: () {
                      Navigator.of(context).popAndPushNamed(profileRoute);
                    },
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(user.data.photoUrl.toString()),
                      backgroundColor: Colors.grey[50],
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Deals'),
                  leading: Icon(Icons.local_offer),
                  onTap: () {
                    Navigator.of(context).popAndPushNamed(dealsRoute);
                  },
                ),
                ListTile(
                  title: Text('My account'),
                  leading: Icon(Icons.account_circle),
                  onTap: () {
                    Navigator.of(context).popAndPushNamed(profileRoute);
                  },
                ),
                ListTile(
                  title: Text('Product List'),
                  leading: Icon(Icons.list),
                  onTap: () {
                    Navigator.of(context).popAndPushNamed(productListRoute);
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.power_settings_new),
            onTap: () async {
              Navigator.pop(context);
              await Provider.of<AuthService>(context, listen: false).signOut();
            },
          ),
        ],
      ),
    );
  }
}
