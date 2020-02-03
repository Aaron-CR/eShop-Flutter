import 'package:eshop/core/base/base_view_model.dart';
import 'package:eshop/core/locator.dart';
import 'package:eshop/core/models/product_models.dart';
import 'package:eshop/core/services/dialog_service.dart';
import 'package:eshop/core/services/firestore_service.dart';
import 'package:eshop/core/services/navigation_service.dart';
import 'package:flutter/foundation.dart';

class ProductFormViewModel extends BaseViewModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Product edittingProduct;
  bool get edditting => edittingProduct != null;

  Future addProduct({@required Product product}) async {
    setBusy(true);

    // TODO: add id on create a new product
    var result;
    if (!edditting) {
      product.userId = currentUser.uid;
      result = await _firestoreService.addProduct(product);
    } else {
      product.userId = edittingProduct.userId;
      product.id = edittingProduct.id;
      result = await _firestoreService.updateProduct(product);
    }
    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Could not creat product',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Product successfully Added',
        description: 'Your product has been created',
      );
    }

    _navigationService.pop();
  }

  /* void setEdittingPost(Product edittingProduct) {
    _edittingProduct = edittingProduct;
  } */
}
