import 'package:eshop/core/locator.dart';
import 'package:eshop/core/models/product_models.dart';
import 'package:eshop/core/services/navigation_service.dart';
import 'package:eshop/shared/ui_helpers.dart';
import 'package:eshop/theme/theme.dart';
import 'package:eshop/views/product_list/product_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
          onPressed: model.navigateToProductFormView,
        ),
        body: Container(
          child: model.myProducts != null
              ? ListView.builder(
                  padding: EdgeInsets.all(12.0),
                  itemExtent: 100.0,
                  itemCount: model.myProducts.length,
                  itemBuilder: (context, index) => GestureDetector(
                      onTap: () => model.navigateToProductDetailsView(index),
                      child: _buildListItem(
                          context, model.myProducts[index], model, index)),
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

  Widget _buildListItem(BuildContext context, Product product,
      ProductListViewModel model, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
            color: Colors.white,
            height: 100.0,
            child: Center(
              child: ListTile(
                leading: ClipOval(
                  child: FadeInImage(
                    width: 52.0,
                    height: 52.0,
                    fit: BoxFit.contain,
                    placeholder:
                        AssetImage("assets/images/product-placeholder.png"),
                    image: NetworkImage(product.photoURL),
                  ),
                ),
                title: Text(product.productName),
                subtitle: Text('\$ ${product.price}'),
              ),
            ),
          ),
          actions: <Widget>[
            IconSlideAction(
              caption: 'Edit',
              color: Colors.grey[300].withOpacity(0.7),
              foregroundColor: Colors.green[600],
              icon: Icons.edit,
              onTap: () => model.editProduct(index),
            ),
          ],
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Delete',
              color: Colors.grey[300].withOpacity(0.7),
              foregroundColor: colorScheme.primary,
              icon: Icons.delete,
              onTap: () => model.deleteProduct(index),
            ),
          ],
        ),
      ),
    );
  }
}
