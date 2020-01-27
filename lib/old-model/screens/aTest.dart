import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Test extends StatefulWidget {
  Test({Key key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final ScrollController scrollController = ScrollController();
  Firestore _firestore = Firestore.instance;
  List<DocumentSnapshot> products = [];
  DocumentSnapshot lastDocument;
  bool loadingProducts = true;
  bool gettingMoreProducts = false;
  bool moreProductsAvailable = true;
  int perPage = 4;

  getProducts() async {
    // TODO: check if orderBy('id', descending: true) works as intended
    Query query = _firestore
        .collection('products')
        .orderBy('id', descending: true)
        .limit(perPage);
    setState(() {
      loadingProducts = true;
    });
    QuerySnapshot querySnapshot = await query.getDocuments();
    products = querySnapshot.documents;
    lastDocument = querySnapshot.documents[querySnapshot.documents.length - 1];
    setState(() {
      loadingProducts = false;
    });
  }

  getMoreProducts() async {
    print('getMoreProducts() called');

    if (moreProductsAvailable == false) {
      print('no more products');
      return;
    }

    if (gettingMoreProducts == true) {
      return;
    }
    gettingMoreProducts = true;

    // TODO: check if orderBy('id', descending: true) works as intended
    Query query = _firestore
        .collection('products')
        .orderBy('id', descending: true)
        .startAfter([lastDocument.data['id']]).limit(perPage);

    QuerySnapshot querySnapshot = await query.getDocuments();

    if (querySnapshot.documents.length < perPage) {
      moreProductsAvailable = false;
    }

    lastDocument = querySnapshot.documents[querySnapshot.documents.length - 1];

    products.addAll(querySnapshot.documents);

    setState(() {
      gettingMoreProducts = false;
    });
  }

  @override
  void initState() {
    // products = ProductModel();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        getMoreProducts();
      }
    });
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    //final productProvider = Provider.of<TestService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('eshop/old-model'),
        centerTitle: true,
      ),
      body: loadingProducts == true
          ? Container(
              child: Center(
                child: Text('Loading...'),
              ),
            )
          : Container(
              child: products.length == 0
                  ? Center(
                      child: Text('No products to show'),
                    )
                  : StaggeredGridView.countBuilder(
                      padding: EdgeInsets.all(6.0),
                      crossAxisCount: 4,
                      itemCount: products.length + 1,
                      controller: scrollController,
                      itemBuilder: (BuildContext _context, int index) {
                        if (index < products.length) {
                          //return ProductCard(product: products[index].data);
                          return Text('data');
                        } else if (/* products.hasMore */ false) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 32.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        } else {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 32.0),
                            child: Center(child: Text('nothing more to load!')),
                          );
                        }
                      },
                      staggeredTileBuilder: (_) => StaggeredTile.fit(2),
                    ),
            ),
    );
  }
}

/* StaggeredGridView.countBuilder(
              padding: EdgeInsets.all(6.0),
              crossAxisCount: 4,
              itemCount: products.length + 1,
              controller: scrollController,
              itemBuilder: (BuildContext _context, int index) {
                if (index < products.length) {
                  //return ProductCard(product: products[index].data['productName']);
                  return ListTile(
                    title: Text(products[index].data['productName']),
                  );
                } else if (/* products.hasMore */ false) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.0),
                    child: Center(child: Text('nothing more to load!')),
                  );
                }
              },
              staggeredTileBuilder: (_) => StaggeredTile.fit(2),
            ) */
