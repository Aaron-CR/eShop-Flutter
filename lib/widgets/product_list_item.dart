import 'package:eshop/core/models/product_models.dart';
import 'package:eshop/theme/theme.dart';
import 'package:eshop/views/product_list/product_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProductListItem extends StatelessWidget {
  final Product product;
  final ProductListViewModel model;
  final int index;

  const ProductListItem(this.product, this.model, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
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
                      Icon(
                        Icons.local_offer,
                        color: product.deal == '1'
                            ? colorScheme.primary
                            : Colors.grey[200],
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
      ),
    );
  }
}
