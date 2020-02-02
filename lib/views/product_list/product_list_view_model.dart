import 'package:eshop/core/base/base_view_model.dart';
import 'package:eshop/core/locator.dart';
import 'package:eshop/core/models/product_models.dart';
import 'package:eshop/core/services/dialog_service.dart';
import 'package:eshop/core/services/firestore_service.dart';
import 'package:eshop/core/services/navigation_service.dart';
import 'package:eshop/constants/route_names.dart';

class ProductListViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();

  List<Product> _myProducts;
  List<Product> get myProducts => _myProducts;

  void listenToMyProducts() {
    setBusy(true);
    _firestoreService.listenToMyProducts(currentUser).listen((productData) {
      List<Product> updatedProducts = productData;
      if (updatedProducts != null && updatedProducts.length > 0) {
        _myProducts = updatedProducts;
        notifyListeners();
      }
    });
    setBusy(false);
  }

  Future<void> onRefresh() async {
    setBusy(true);
    _myProducts.clear();
    listenToMyProducts();
    setBusy(false);
  }

  /* Stream listenToMyProducts() {
    return _firestoreService.listenToMyProducts(currentUser.uid);
  } */

  Future navigateToProductFormView() async {
    await _navigationService.navigateTo(ProductFormViewRoute);
  }

  Future navigateToProductDetailsView(int index) async {
    await _navigationService.navigateTo(ProductDetailsViewRoute,
        arguments: _myProducts[index]);
  }

  void editProduct(int index) {
    _navigationService.navigateTo(ProductFormViewRoute,
        arguments: _myProducts[index]);
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
      await _firestoreService.deleteProduct(_myProducts[index].id);
      setBusy(false);
    }
  }
}
