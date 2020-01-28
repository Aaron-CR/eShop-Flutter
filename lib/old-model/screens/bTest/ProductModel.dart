import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Example data as it might be returned by an external service
/// ...this is often a `Map` representing `JSON` or a `FireStore` document

/// ProductModel has a constructor that can handle the `Map` data
/// ...from the server.
class ProductModel {
  String amazonURL;
  String brand;
  String deal;
  String description;
  String features;
  String id;
  String photoURL;
  String price;
  String productName;
  String stock;
  String userId;

  ProductModel(
      {this.id,
      this.amazonURL,
      this.brand,
      this.deal,
      this.description,
      this.features,
      this.photoURL,
      this.price,
      this.productName,
      this.stock,
      this.userId});

  factory ProductModel.fromServerMap(Map data) {
    return ProductModel(
      id: data['id'],
      amazonURL: data['amazonURL'],
      brand: data['brand'],
      deal: data['deal'],
      description: data['description'],
      features: data['features'],
      photoURL: data['photoURL'],
      price: data['price'],
      productName: data['productName'],
      stock: data['stock'],
      userId: data['userId'],
    );
  }
}

/// PostsModel controls a `Stream` of posts and handles
/// ...refreshing data and loading more posts
///

class PostsModel {
  Firestore _firestore = Firestore.instance;
  Stream<List<ProductModel>> stream;
  bool hasMore = true;
  bool _isLoading = true;
  bool gettingMoreProducts = false;
  List<DocumentSnapshot> products = [];
  DocumentSnapshot lastDocument;
  int perPage = 3;

  PostsModel() {
    getProducts();
    //hasMore = true;
    //refresh();
  }

  getProducts() async {
    Query query = _firestore
        .collection('products')
        .orderBy('id', descending: true)
        .limit(perPage);
    _isLoading = true;
    QuerySnapshot querySnapshot = await query.getDocuments();
    products = querySnapshot.documents;
    lastDocument = querySnapshot.documents[querySnapshot.documents.length - 1];
    _isLoading = false;
  }

  getMoreProducts() async {
    print('getMoreProducts() called');
    if (hasMore == false) {
      print('no more products');
      return;
    }
    if (gettingMoreProducts == true) {
      return;
    }
    gettingMoreProducts = true;
    Query query = _firestore
        .collection('products')
        .orderBy('id', descending: true)
        .startAfter([lastDocument.data['id']]).limit(perPage);
    QuerySnapshot querySnapshot = await query.getDocuments();
    if (querySnapshot.documents.length < perPage) {
      hasMore = false;
    }
    lastDocument = querySnapshot.documents[querySnapshot.documents.length - 1];
    products.addAll(querySnapshot.documents);
    gettingMoreProducts = false;
  }

  Future<void> refresh() {
    return loadMore(clearCachedData: true);
  }

  Future<void> loadMore({bool clearCachedData = false}) {
    if (clearCachedData) {
      print('refresh called');
      products.clear();
      hasMore = true;
    }
    if (_isLoading || !hasMore) {
      return Future.value();
    }
    _isLoading = true;
    return getMoreProducts();
  }
}

/* /// Example data as it might be returned by an external service
/// ...this is often a `Map` representing `JSON` or a `FireStore` document

Firestore _firestore = Firestore.instance;
List<DocumentSnapshot> products = [];
DocumentSnapshot lastDocument;
int perPage = 3;

Future<List<DocumentSnapshot>> _getServerData(int length) async {
  Query query = _firestore
      .collection('products')
      .orderBy('id', descending: true)
      .limit(length);

  QuerySnapshot querySnapshot = await query.getDocuments();
  lastDocument = querySnapshot.documents[querySnapshot.documents.length - 1];
  return products = querySnapshot.documents;
}

/// ProductModel has a constructor that can handle the `Map` data
/// ...from the server.
class ProductModel {
  String amazonURL;
  String brand;
  String deal;
  String description;
  String features;
  String id;
  String photoURL;
  String price;
  String productName;
  String stock;
  String userId;

  ProductModel(
      {this.id,
      this.amazonURL,
      this.brand,
      this.deal,
      this.description,
      this.features,
      this.photoURL,
      this.price,
      this.productName,
      this.stock,
      this.userId});

  factory ProductModel.fromServerMap(Map data) {
    return ProductModel(
      id: data['id'],
      amazonURL: data['amazonURL'],
      brand: data['brand'],
      deal: data['deal'],
      description: data['description'],
      features: data['features'],
      photoURL: data['photoURL'],
      price: data['price'],
      productName: data['productName'],
      stock: data['stock'],
      userId: data['userId'],
    );
  }
}

/// PostsModel controls a `Stream` of posts and handles
/// ...refreshing data and loading more posts
class PostsModel {
  Stream<List<ProductModel>> stream;
  bool hasMore;

  bool _isLoading;
  List<DocumentSnapshot> _data;
  StreamController<List<DocumentSnapshot>> _controller;

  PostsModel() {
    _data = List<DocumentSnapshot>();
    _controller = StreamController<List<DocumentSnapshot>>.broadcast();
    _isLoading = false;
    stream = _controller.stream.map((List<DocumentSnapshot> postsData) {
      return postsData.map((DocumentSnapshot postData) {
        return ProductModel.fromServerMap(postData.data);
      }).toList();
    });
    hasMore = true;
    refresh();
  }

  Future<void> refresh() {
    return loadMore(clearCachedData: true);
  }

  Future<void> loadMore({bool clearCachedData = false}) {
    if (clearCachedData) {
      print('refresh called');
      _data.clear();
      hasMore = true;
    }
    if (_isLoading || !hasMore) {
      return Future.value();
    }
    _isLoading = true;
    return _getServerData(perPage).then((postsData) {
      _isLoading = false;
      _data.addAll(postsData);
      hasMore = (_data.length < 9);
      _controller.add(_data);
    });
  }
} */
