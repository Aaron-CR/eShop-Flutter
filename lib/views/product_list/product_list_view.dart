import 'package:eshop/shared/data_search.dart';
import 'package:eshop/shared/ui_helpers.dart';
import 'package:eshop/theme/theme.dart';
import 'package:eshop/views/product_list/product_list_view_model.dart';
import 'package:eshop/widgets/busy_overlay.dart';
import 'package:eshop/widgets/product_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

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
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(
                      context: context,
                      delegate: DataSearch(model.myProducts, model));
                },
              ),
            ],
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
                        onTap: () => model.navigateToProductDetailsView(index),
                        child: ProductListItem(
                            model.myProducts[index], model, index),
                      ),
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
}
