import 'package:eshop/core/models/product_models.dart';
import 'package:eshop/shared/ui_helpers.dart';
import 'package:eshop/theme/theme.dart';
import 'package:eshop/views/product_list/product_list_view_model.dart';
import 'package:eshop/widgets/busy_overlay.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ProductListViewModel>.withConsumer(
      viewModel: ProductListViewModel(),
      onModelReady: (model) => model.listenToMyProducts(),
      builder: (context, model, child) => BusyOverlay(
        show: model.busy,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Product List',
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: !model.busy ? Icon(Icons.add) : CircularProgressIndicator(),
            onPressed: model.navigateToProductFormView,
          ),
          body: RefreshIndicator(
            onRefresh: () => model.onRefresh(),
            child: Container(
              child: model.myProducts != null
                  ? ListView.builder(
                      padding: EdgeInsets.all(12.0),
                      itemCount: model.myProducts.length,
                      itemBuilder: (context, index) => GestureDetector(
                          onTap: () =>
                              model.navigateToProductDetailsView(index),
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
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, Product product,
      ProductListViewModel model, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.16,
          child: Container(
            color: Colors.white,
            child: Center(
              child: ListTile(
                contentPadding: EdgeInsets.all(16.0),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Container(
                    color: Colors.white,
                    child: FadeInImage(
                      width: 52.0,
                      height: 52.0,
                      fit: BoxFit.contain,
                      placeholder:
                          AssetImage("assets/images/product-placeholder.png"),
                      image: NetworkImage(product.photoURL),
                    ),
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    product.deal == '1'
                        ? Icon(
                            Icons.local_offer,
                            color: colorScheme.primary,
                          )
                        : Icon(
                            Icons.local_offer,
                            color: Colors.grey[200],
                          ),
                    product.stock == '1'
                        ? Icon(
                            Icons.check_box,
                            color: Color(0xFF28A745),
                          )
                        : Icon(
                            Icons.indeterminate_check_box,
                            color: Colors.grey[200],
                          ),
                  ],
                ),
                title: Text(product.productName),
                subtitle: Text('\$ ${product.price}'),
              ),
            ),
          ),
          actions: <Widget>[
            IconSlideAction(
              caption: 'Edit',
              color: Colors.blueGrey[400],
              icon: Icons.edit,
              onTap: () => model.editProduct(index),
            ),
          ],
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Delete',
              color: colorScheme.primary,
              icon: Icons.delete_forever,
              onTap: () => model.deleteProduct(index),
            ),
          ],
        ),
      ),
    );
  }
}
