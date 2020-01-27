import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/old-model/models/product.dart';
import 'package:eshop/old-model/router.dart';
import 'package:eshop/old-model/services/auth.dart';
import 'package:eshop/old-model/services/crud.dart';
import 'package:eshop/old-model/shared/constants.dart';
import 'package:eshop/old-model/widgets/spinner.dart';
import 'package:eshop/old-model/widgets/product_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Crud>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('eshop/old-model'),
        centerTitle: true,
      ),
      drawer: FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (BuildContext context, AsyncSnapshot user) {
          return user.hasData ? buildDrawer(context, user) : Spinner();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kMainColor,
        onPressed: () {
          Navigator.pushNamed(context, addProductRoute);
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: StreamBuilder(
          stream: productProvider.fetchProductsAsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              products = snapshot.data.documents
                  .map((doc) => Product.fromMap(doc.data))
                  .toList();
              return RefreshIndicator(
                onRefresh: () {},
                child: StaggeredGridView.countBuilder(
                  padding: EdgeInsets.all(6.0),
                  crossAxisCount: 4,
                  itemCount: products.length,
                  itemBuilder: (buildContext, index) =>
                      //ProductCard(product: products[index]),
                      Text('s'),
                  staggeredTileBuilder: (_) => StaggeredTile.fit(2),
                ),
              );
            } else {
              return Spinner();
            }
          },
        ),

        /// Using StreamBuilder instead of FutureBuilder for instant UI update
        /* 
        
        FutureBuilder(
          future: productProvider.fetchProducts(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return StaggeredGridView.countBuilder(
                padding: EdgeInsets.all(6.0),
                crossAxisCount: 4,
                itemCount: snapshot.data.length,
                itemBuilder: (buildContext, index) =>
                    ProductCard(product: snapshot.data[index]),
                staggeredTileBuilder: (_) => StaggeredTile.fit(2),
              );
            } else {
              return Spinner();
            }
          },
        ),

        StreamBuilder(
          stream: productProvider.fetchProductsAsStream(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              products = snapshot.data.documents
                  .map((doc) => Product.fromMap(doc.data, doc.documentID))
                  .toList();
              return StaggeredGridView.countBuilder(
                padding: EdgeInsets.all(6.0),
                crossAxisCount: 4,
                itemCount: products.length,
                itemBuilder: (buildContext, index) =>
                    ProductCard(product: products[index]),
                staggeredTileBuilder: (_) => StaggeredTile.fit(2),
              );
            } else {
              return Spinner();
            }
          },
        ), */
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
                    Navigator.of(context).popAndPushNamed(accountRoute);
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
                      Navigator.of(context).popAndPushNamed(accountRoute);
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
                    Navigator.of(context).popAndPushNamed(accountRoute);
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
