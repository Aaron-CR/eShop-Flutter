import 'package:eshop/core/base/base_view_model.dart';
import 'package:eshop/core/locator.dart';
import 'package:eshop/core/models/product_models.dart';
import 'package:eshop/core/services/dialog_service.dart';
import 'package:eshop/core/services/firestore_service.dart';

class HomeViewModel extends BaseViewModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();

  List<Product> _products;
  List<Product> get products => _products;

  // TODO(FilledStacks): expose the stream through the viewmodel instead of subscribing and use it in your builder.﻿
  void listenToProducts() {
    setBusy(true);
    _firestoreService.listenToProducts().listen((productData) {
      List<Product> updatedProducts = productData;
      if (updatedProducts != null && updatedProducts.length > 0) {
        _products = updatedProducts;
        notifyListeners();
      }
    });
    setBusy(false);
  }

}
