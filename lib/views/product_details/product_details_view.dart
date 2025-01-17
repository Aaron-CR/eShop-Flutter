import 'package:eshop/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:eshop/core/models/product_models.dart';
import 'package:eshop/widgets/stock_label.dart';

class ProductDetailsView extends StatefulWidget {
  final Product product;

  ProductDetailsView({this.product});

  @override
  _ProductDetailsViewState createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {},
          ),
        ],
      ),
      // TODO: review if ListView is the best Widget for this case
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildImage(context),
              _buildBody(context),
            ],
          ),
        ],
      ),
    );
  }

  Hero _buildImage(BuildContext context) {
    return Hero(
      tag: widget.product.id,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Image.network(
            widget.product.photoURL,
            height: MediaQuery.of(context).size.height * 0.35,
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.product.brand,
            style: Theme.of(context).textTheme.caption,
          ),
          Text(
            widget.product.productName,
            style: Theme.of(context).textTheme.title,
          ),
          Text(
            '\$ ${widget.product.price}',
            style: Theme.of(context).textTheme.headline,
          ),
          _buildStockLabel(),
          _buildButtonRow(),
          Divider(thickness: 1.3),
          _buildTextBlock('Product Description', widget.product.description),
          Divider(thickness: 1.3),
          _buildTextBlock('Product Features', widget.product.features),
        ],
      ),
    );
  }

  Widget _buildStockLabel() {
    return widget.product.stock == '1'
        ? StockLabel(
            color: Color(0xFF28A745),
            text: 'IN STOCK',
          )
        : StockLabel(
            color: Color(0xFFDC3545),
            text: 'OUT STOCK',
          );
  }

  Widget _buildButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Flexible(
          flex: 3,
          child: Container(
            width: double.infinity,
            child: RaisedButton(
              onPressed: () => _launchURL(widget.product.amazonURL),
              child: Text('Buy'),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: RawMaterialButton(
            onPressed: () {
              setState(() {
                isFavourite = !isFavourite;
              });
            },
            child: Icon(
              Icons.favorite,
              color: isFavourite ? colorScheme.primary : Colors.grey,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: EdgeInsets.all(16.0),
          ),
        ),
      ],
    );
  }

  Widget _buildTextBlock(String title, String body) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 12.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Text(
            body,
            style: Theme.of(context).textTheme.body1,
          ),
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
