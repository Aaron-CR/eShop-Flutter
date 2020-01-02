import 'package:cloud_firestore/cloud_firestore.dart';

class DataApiService {

  // collection reference
  final CollectionReference collectionReference = Firestore.instance.collection('products');
}