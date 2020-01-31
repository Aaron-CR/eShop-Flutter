import 'package:eshop/core/base/base_view_model.dart';
import 'package:eshop/core/locator.dart';
import 'package:eshop/core/models/product_models.dart';
import 'package:eshop/core/services/firestore_service.dart';

class DealsViewModel extends BaseViewModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();

  List<Product> _deals;
  List<Product> get deals => _deals;

  void listenToDeals() {
    setBusy(true);
    _firestoreService.listenToDeals().listen((productData) {
      List<Product> updatedProducts = productData;
      if (updatedProducts != null && updatedProducts.length > 0) {
        _deals = updatedProducts;
        notifyListeners();
      }
    });
    setBusy(false);
  }
}
