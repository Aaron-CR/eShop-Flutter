import 'package:eshop/shared/ui_helpers.dart';
import 'package:eshop/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:eshop/views/home/home_view_model.dart';
import 'package:eshop/widgets/product_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withConsumer(
      viewModel: HomeViewModel(),
      onModelReady: (model) => model.listenToProducts(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('eShop'),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                    context: context, delegate: DataSearch(model.products));
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: ListView(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      onDetailsPressed: () => model.navigateToAccountView(),
                      accountName: Text(
                        model.currentUser.displayName,
                        style: TextStyle(color: Colors.black),
                      ),
                      accountEmail: Text(
                        model.currentUser.email,
                        style: TextStyle(color: Colors.black),
                      ),
                      decoration: BoxDecoration(color: Colors.grey[50]),
                      currentAccountPicture: GestureDetector(
                        onTap: () => model.navigateToAccountView(),
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(model.currentUser.photoURL),
                          backgroundColor: Colors.grey[300],
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text('Deals'),
                      leading: Icon(Icons.local_offer),
                      onTap: () => model.navigateToDealsView(),
                    ),
                    ListTile(
                      title: Text('My account'),
                      leading: Icon(Icons.account_circle),
                      onTap: () => model.navigateToAccountView(),
                    ),
                    ListTile(
                      title: Text('Product List'),
                      leading: Icon(Icons.list),
                      onTap: () => model.navigateToProductListView(),
                    ),
                    ListTile(
                      title: Text('Experimental'),
                      leading: Icon(Icons.build),
                      onTap: () =>
                          model.navigateToExperimentalProductFormView(),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.power_settings_new),
                onTap: () => model.signOut(),
              ),
            ],
          ),
        ),
        body: Container(
          child: model.products != null
              ? StaggeredGridView.countBuilder(
                  padding: EdgeInsets.all(6.0),
                  staggeredTileBuilder: (_) => StaggeredTile.fit(1),
                  crossAxisCount: isPortrait(context) ? 2 : 3,
                  itemCount: model.products.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => model.navigateToProductDetailsView(index),
                    child: ProductItem(product: model.products[index]),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(colorScheme.primary),
                  ),
                ),
        ),
      ),
    );
  }
}
