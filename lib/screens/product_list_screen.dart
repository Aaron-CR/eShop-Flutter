import 'package:flutter/material.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product List',
        ),
      ),
      body: Container(
        child: Center(
          child: Container(
            child: Text('Product List'),
          ),
        ),
      ),
    );
  }
}
