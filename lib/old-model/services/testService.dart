import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestService extends ChangeNotifier {
  Firestore _firestore = Firestore.instance;
  List<DocumentSnapshot> _products = [];
  bool _loadingProducts = true;

  getProducts() async {
    Query query = _firestore.collection('products').orderBy(true).limit(5);

    _loadingProducts = true;
    QuerySnapshot querySnapshot = await query.getDocuments();
    _products = querySnapshot.documents;
    _loadingProducts = false;
  }
}
