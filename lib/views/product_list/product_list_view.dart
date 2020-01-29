import 'package:eshop/shared/ui_helpers.dart';
import 'package:eshop/theme/theme.dart';
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
      body: Padding(
        padding: EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '☹️',
              style: textTheme.display4,
            ),
            Text(
              'Empty List',
              style: textTheme.display1,
            ),
            Text(
              'Looks like you dont have any product.\nTry adding one',
              style: textTheme.body1,
            ),
            verticalSpaceMedium,
            RaisedButton(
              onPressed: () {
                // TODO: add routing to ProductFormView.
              },
              child: Text('Add Product'),
            )
          ],
        ),
      ),
    );
  }
}
