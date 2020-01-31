import 'package:eshop/shared/ui_helpers.dart';
import 'package:eshop/theme/theme.dart';
import 'package:eshop/views/deals/deals_view_model.dart';
import 'package:eshop/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider_architecture/provider_architecture.dart';

class DealsView extends StatelessWidget {
  const DealsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<DealsViewModel>.withConsumer(
      viewModel: DealsViewModel(),
      onModelReady: (model) => model.listenToDeals(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Deals',
          ),
        ),
        body: Container(
          child: model.deals != null
              ? StaggeredGridView.countBuilder(
                  padding: EdgeInsets.all(6.0),
                  staggeredTileBuilder: (_) => StaggeredTile.fit(1),
                  crossAxisCount: isPortrait(context) ? 2 : 3,
                  itemCount: model.deals.length,
                  itemBuilder: (context, index) => GestureDetector(
                    // TODO: move onTap() propierty to ProductListView
                    //onTap: () => model.editPost(index),
                    child: ProductItem(
                      product: model.deals[index],
                      //onDeleteItem: () => model.deleteProduct(index),
                    ),
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
