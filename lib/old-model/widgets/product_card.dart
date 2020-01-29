import 'package:eshop/models/product_models.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  //final ProductModel product;

  ProductCard({@required this.product});

  @override
  Widget build(BuildContext context) {
    // TODO: add disccount tag and fav icon
    return GestureDetector(
      onTap: () {
        /* Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailsScreen(product: product),
          ),
        ); */
      },
      child: Card(
        child: Hero(
          tag: product.id,
          child: Column(
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
                  // TODO: add discount tag and fav icon
                  //Icon(Icons.favorite, color: Colors.grey),
                ],
              ),
              Divider(thickness: 1.3),
              buildInfo(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfo(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 4),
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
    );
  }
}
