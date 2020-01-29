import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eshop/models/user_models.dart';
import 'package:eshop/models/product_models.dart';
import 'package:flutter/services.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection('users');

  final CollectionReference _productsCollectionReference =
      Firestore.instance.collection('products');

  final StreamController<List<Product>> _productsController =
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

  Stream listenToProductsRealTime() {
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

  Future deleteProduct(String documentId) async {
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
