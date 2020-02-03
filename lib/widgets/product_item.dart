import 'package:eshop/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:eshop/core/models/product_models.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final Function onDeleteItem;
  const ProductItem({
    Key key,
    this.product,
    this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              // TODO: Add a gradient background
              Padding(
                padding: EdgeInsets.all(8.0),
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder:
                      AssetImage("assets/images/product-placeholder.png"),
                  image: NetworkImage(
                    product.photoURL,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // TODO: search with git '1'
                    product.deal == true
                        ? Container(
                            height: 24.0,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6.0),
                              child: Text(
                                '-10% ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.primary,
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                          )
                        : SizedBox.shrink(),
                    // TODO: Fix gesture detector
                    GestureDetector(
                      onTap: () {
                        print('object');
                      },
                      child: Icon(Icons.favorite_border, color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
          Divider(thickness: 1.3),
          Container(
            margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // TODO: display price with -10%
                Text(
                  '\$ ${product.price}',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(height: 8),
                Text(
                  product.productName,
                  style: Theme.of(context).textTheme.subhead,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
