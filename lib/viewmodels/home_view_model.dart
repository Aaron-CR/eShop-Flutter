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
  Stream<List<Product>> _productsStream;
  List<Product> get products => _products;

  Future fetchProducts() async {
    setBusy(true);
    // TODO: Find or Create a TaskType that will automaticall do the setBusy(true/false) when being run.
    var productsResults = await _firestoreService.getProductsOnceOff();
    setBusy(false);

    if (productsResults is List<Product>) {
      _products = productsResults;
      notifyListeners();
    } else {
      await _dialogService.showDialog(
        title: 'Products Update Failed',
        description: productsResults,
      );
    }
  }

  Stream listenToProductsRealTime() {
    setBusy(true);
    // TODO: Find or Create a TaskType that will automaticall do the setBusy(true/false) when being run.
    var productsResults = _firestoreService.listenToProductsRealTime();
    setBusy(false);

    if (productsResults is List<Product>) {
      _productsStream = productsResults;
      notifyListeners();
    } else {
      _dialogService.showDialog(
        title: 'Products Update Failed',
        description: 'Products Update Failed',
      );
    }
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
    await fetchProducts();
  }

  void editPost(int index) {
    _navigationService.navigateTo(CreateProductViewRoute,
        arguments: _products[index]);
  }
}
