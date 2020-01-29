import 'package:flutter/material.dart';

class ProductListView extends StatelessWidget {
  const ProductListView({Key key}) : super(key: key);

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
