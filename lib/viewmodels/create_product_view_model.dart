import 'package:eshop/locator.dart';
import 'package:eshop/models/product_models.dart';
import 'package:eshop/services/dialog_service.dart';
import 'package:eshop/services/firestore_service.dart';
import 'package:eshop/services/navigation_service.dart';
import 'package:eshop/viewmodels/base_model.dart';
import 'package:flutter/foundation.dart';

class CreateProductViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future addProduct({@required String productName}) async {
    setBusy(true);
    var result = await _firestoreService
        .addProduct(Product(productName: productName, userId: currentUser.uid));
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
}
