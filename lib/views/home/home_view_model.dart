import 'package:eshop/constants/route_names.dart';
import 'package:eshop/core/base/base_view_model.dart';
import 'package:eshop/core/locator.dart';
import 'package:eshop/core/models/product_models.dart';
import 'package:eshop/core/services/firestore_service.dart';
import 'package:eshop/core/services/navigation_service.dart';

class HomeViewModel extends BaseViewModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<Product> _products;
  List<Product> get products => _products;

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

  Future navigateToAccountView() async {
    await _navigationService.navigateTo(AccountRoute);
  }

  Future navigateToDealsView() async {
    await _navigationService.navigateTo(DealsRoute);
  }

  Future navigateToProductListView() async {
    await _navigationService.navigateTo(ProductListRoute);
  }

  Future navigateToProductDetailsView(int index) async {
    await _navigationService.navigateTo(ProductDetailsRoute,
        arguments: products[index]);
  }
}
