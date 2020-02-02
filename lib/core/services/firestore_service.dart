import 'dart:async';

import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/core/models/user_models.dart';
import 'package:eshop/core/models/product_models.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection('users');

  final CollectionReference _productsCollectionReference =
      Firestore.instance.collection('products');

  final StreamController<List<Product>> _productsController =
      StreamController<List<Product>>.broadcast();

  final StreamController<List<Product>> _myProductsController =
      StreamController<List<Product>>.broadcast();

  final StreamController<List<Product>> _dealsController =
      StreamController<List<Product>>.broadcast();

  Future createUser(User user) async {
    try {
      await _usersCollectionReference.document(user.uid).setData(user.toJson());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.document(uid).get();
      return User.fromData(userData.data);
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future addProduct(Product product) async {
    try {
      await _productsCollectionReference.add(product.toMap());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future getProductsOnceOff() async {
    try {
      var productDocuments = await _productsCollectionReference.getDocuments();
      if (productDocuments.documents.isNotEmpty) {
        return productDocuments.documents
            .map((snapshot) =>
                Product.fromMap(snapshot.data, snapshot.documentID))
            .where((mappedItem) => mappedItem.productName != null)
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Stream listenToProducts() {
    // Register the handler for when the products data changes
    _productsCollectionReference.snapshots().listen((productsSnapshot) {
      if (productsSnapshot.documents.isNotEmpty) {
        var products = productsSnapshot.documents
            .map((snapshot) =>
                Product.fromMap(snapshot.data, snapshot.documentID))
            .toList();

        // Add the products onto the controller
        _productsController.add(products);
      }
    });

    return _productsController.stream;
  }

  /// Used in Product List View
  /// return a list of products with a matching userId
  Stream listenToMyProducts(User user) {
    // Register the handler for when the products data changes
    _productsCollectionReference.snapshots().listen((productsSnapshot) {
      if (productsSnapshot.documents.isNotEmpty) {
        var myProducts = productsSnapshot.documents
            .map((snapshot) =>
                Product.fromMap(snapshot.data, snapshot.documentID))
            .where((mappedItem) =>
                mappedItem.userId == user.uid || user.userRole == 'Admin')
            .toList();

        // Add the products onto the controller
        _myProductsController.add(myProducts);
      }
    });

    return _myProductsController.stream;
  }

  /// Used in Deals View
  /// return a list of products with a deal
  Stream listenToDeals() {
    // Register the handler for when the products data changes
    _productsCollectionReference.snapshots().listen((productsSnapshot) {
      if (productsSnapshot.documents.isNotEmpty) {
        var deals = productsSnapshot.documents
            .map((snapshot) =>
                Product.fromMap(snapshot.data, snapshot.documentID))
            .where((mappedItem) => mappedItem.deal == '1')
            .toList();

        // Add the products onto the controller
        _dealsController.add(deals);
      }
    });

    return _dealsController.stream;
  }

  /// Deletes the document referred to by this [documentId]
  Future<void> deleteProduct(String documentId) async {
    await _productsCollectionReference.document(documentId).delete();
  }

  Future updateProduct(Product product) async {
    try {
      await _productsCollectionReference
          .document(product.id)
          .updateData(product.toMap());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }
}
