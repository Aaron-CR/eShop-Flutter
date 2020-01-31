import 'package:eshop/core/locator.dart';
import 'package:eshop/core/services/navigation_service.dart';
import 'package:eshop/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:eshop/views/home/home_view_model.dart';
import 'package:eshop/shared/app_colors.dart';
import 'package:eshop/widgets/product_item.dart';
import 'package:eshop/constants/route_names.dart';

final NavigationService _navigationService = locator<NavigationService>();

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
        ),
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: ListView(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      onDetailsPressed: () {
                        _navigationService.popAndNavigateTo(AccountRoute);
                      },
                      accountName: Text(
                        'User Name',
                        style: TextStyle(color: Colors.black),
                      ),
                      accountEmail: Text(
                        'User Email',
                        style: TextStyle(color: Colors.black),
                      ),
                      decoration: BoxDecoration(color: Colors.grey[50]),
                      currentAccountPicture: GestureDetector(
                        onTap: () {
                          _navigationService.popAndNavigateTo(AccountRoute);
                        },
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/user/user-thumb.jpg'),
                          backgroundColor: Colors.grey[50],
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text('Deals'),
                      leading: Icon(Icons.local_offer),
                      onTap: () {
                        _navigationService.popAndNavigateTo(DealsRoute);
                      },
                    ),
                    ListTile(
                      title: Text('My account'),
                      leading: Icon(Icons.account_circle),
                      onTap: () {
                        _navigationService.popAndNavigateTo(AccountRoute);
                      },
                    ),
                    ListTile(
                      title: Text('Product List'),
                      leading: Icon(Icons.list),
                      onTap: () {
                        _navigationService.popAndNavigateTo(ProductListRoute);
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text('Logout'),
                leading: Icon(Icons.power_settings_new),
                onTap: () {},
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: !model.busy ? Icon(Icons.add) : CircularProgressIndicator(),
          onPressed: model.navigateToCreateView,
        ),
        body: Container(
          child: model.products != null
              ? StaggeredGridView.countBuilder(
                  padding: EdgeInsets.all(6.0),
                  staggeredTileBuilder: (_) => StaggeredTile.fit(1),
                  crossAxisCount: isPortrait(context) ? 2 : 3,
                  itemCount: model.products.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => model.editPost(index),
                    child: ProductItem(
                      product: model.products[index],
                      onDeleteItem: () => model.deleteProduct(index),
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(kMainColor),
                  ),
                ),
        ),
      ),
    );
  }
}

/// Last working code
/* 
model.products != null
              ? StaggeredGridView.countBuilder(
                  padding: EdgeInsets.all(6.0),
                  staggeredTileBuilder: (_) => StaggeredTile.fit(2),
                  crossAxisCount: 4,
                  itemCount: model.products.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => model.editPost(index),
                    child: ProductItem(
                      product: model.products[index],
                      onDeleteItem: () => model.deleteProduct(index),
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(kMainColor),
                  ),
                ),
 */
/* 
StreamBuilder(
            stream: model.listenToProductsRealTime(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return StaggeredGridView.countBuilder(
                  padding: EdgeInsets.all(6.0),
                  crossAxisCount: 4,
                  itemCount: snapshot.data.length,
                  itemBuilder: (buildContext, index) =>
                      ProductItem(product: snapshot.data[index]),
                  staggeredTileBuilder: (_) => StaggeredTile.fit(2),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(kMainColor),
                  ),
                );
              }
            },
          ),
 */
