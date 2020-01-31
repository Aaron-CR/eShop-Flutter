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
    _firestoreService.listenToMyProducts(currentUser.uid).listen((productData) {
      List<Product> updatedProducts = productData;
      if (updatedProducts != null && updatedProducts.length > 0) {
        _myProducts = updatedProducts;
        notifyListeners();
      }
    });
    setBusy(false);
  }

  /* Stream listenToMyProducts() {
    return _firestoreService.listenToMyProducts(currentUser.uid);
  } */

  Future navigateToCreateView() async {
    await _navigationService.navigateTo(CreateProductViewRoute);
  }

  void editPost(int index) {
    _navigationService.navigateTo(CreateProductViewRoute,
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
