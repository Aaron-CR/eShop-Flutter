import 'package:eshop/screens/bTest/ProductModel.dart';
import 'package:flutter/material.dart';


class Post extends StatelessWidget {
  final ProductModel product;

  const Post({
    Key key,
    @required this.product,
  })  : assert(product != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(
        fit: BoxFit.cover,
        placeholder: AssetImage("assets/images/product-placeholder.png"),
        image: NetworkImage(
          product.photoURL,
        ),
      ),
      title: Text(product.productName),
    );
  }
}
