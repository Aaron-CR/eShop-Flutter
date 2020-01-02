import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Details',
        ),
      ),
      body: Container(
        child: Center(
          child: Container(
            child: Text('Product Details'),
          ),
        ),
      ),
    );
  }
}
