import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/constants/route_names.dart';
import 'package:eshop/core/locator.dart';
import 'package:eshop/core/models/product_models.dart';
import 'package:eshop/core/services/navigation_service.dart';
import 'package:eshop/shared/ui_helpers.dart';
import 'package:eshop/theme/theme.dart';
import 'package:eshop/views/product_list/product_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final NavigationService _navigationService = locator<NavigationService>();

class ProductListView extends StatelessWidget {
  const ProductListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ProductListViewModel>.withConsumer(
      viewModel: ProductListViewModel(),
      onModelReady: (model) => model.listenToMyProducts(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Product List',
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: !model.busy ? Icon(Icons.add) : CircularProgressIndicator(),
          onPressed: model.navigateToCreateView,
        ),
        body: Container(
          child: model.myProducts != null
              ? ListView.builder(
                  itemExtent: 80.0,
                  itemCount: model.myProducts.length,
                  itemBuilder: (context, index) =>
                      _buildListItem(context, model.myProducts[index]),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '☹️',
                        style: textTheme.display3,
                      ),
                      Text(
                        'No Products',
                        style: textTheme.headline,
                      ),
                      verticalSpaceSmall,
                      Text(
                        'Please tap the + to add your first product.',
                        style: textTheme.caption,
                        textAlign: TextAlign.center,
                      ),
                      verticalSpaceMedium,
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, Product product) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.photoURL),
        backgroundColor: Colors.grey[50],
      ),
      title: Text(product.productName),
      subtitle: Text(product.price.toString()),
    );
  }
}

/* 
return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '☹️',
                      style: textTheme.display3,
                    ),
                    Text(
                      'No Products',
                      style: textTheme.headline,
                    ),
                    verticalSpaceSmall,
                    Text(
                      'Please tap the + to add your first product.',
                      style: textTheme.caption,
                      textAlign: TextAlign.center,
                    ),
                    verticalSpaceMedium,
                  ],
                ),
              );
            return ListView.builder(
              itemExtent: 80.0,
              itemCount: products.length,
              itemBuilder: (context, index) =>
                  _buildListItem(context, products[index]),
            );

 */
