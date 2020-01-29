import 'package:eshop/constants/route_names.dart';
import 'package:eshop/locator.dart';
import 'package:eshop/models/product_models.dart';
import 'package:eshop/services/dialog_service.dart';
import 'package:eshop/services/firestore_service.dart';
import 'package:eshop/services/navigation_service.dart';
import 'package:eshop/viewmodels/base_model.dart';

class HomeViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();

  List<Product> _products;
  List<Product> get products => _products;

  void listenToProducts() {
    setBusy(true);
    _firestoreService.listenToProductsRealTime().listen((productData) {
      List<Product> updatedProducts = productData;
      if (updatedProducts != null && updatedProducts.length > 0) {
        _products = updatedProducts;
        notifyListeners();
      }
    });
    setBusy(false);
  }

  Future deleteProduct(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you sure?',
      description: 'Do you really want to delete the product?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse.confirmed) {
      setBusy(true);
      await _firestoreService.deleteProduct(_products[index].id);
      setBusy(false);
    }
  }

  Future navigateToCreateView() async {
    await _navigationService.navigateTo(CreateProductViewRoute);
    await listenToProducts();
  }

  void editPost(int index) {
    _navigationService.navigateTo(CreateProductViewRoute,
        arguments: _products[index]);
  }
}
