import 'package:eshop/constants/route_names.dart';
import 'package:eshop/core/base/base_view_model.dart';
import 'package:eshop/core/locator.dart';
import 'package:eshop/core/models/product_models.dart';
import 'package:eshop/core/services/authentication_service.dart';
import 'package:eshop/core/services/firestore_service.dart';
import 'package:eshop/core/services/navigation_service.dart';

class HomeViewModel extends BaseViewModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  List<Product> _products;
  List<Product> get products => _products;

  String header = 'Hello, world!';
  String subtitle =
      'This is a template for a simple marketing or informational website. It includes a large callout called a jumbotron and three supporting pieces of content.';

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

  Future<void> signOut() async {
    await _authenticationService.signOut();
    await _navigationService.pushReplacementNamed(SignInViewRoute);
  }

  Future navigateToAccountView() async {
    await _navigationService.popAndPushNamed(AccountViewRoute);
  }

  Future navigateToDealsView() async {
    await _navigationService.pushNamed(DealsViewRoute);
  }

  Future navigateToProductListView() async {
    await _navigationService.popAndPushNamed(ProductListViewRoute);
  }

  Future navigateToProductDetailsView(int index) async {
    await _navigationService.pushNamed(ProductDetailsViewRoute,
        arguments: products[index]);
  }

  Future navigateToExperimentalProductFormView() async {
    await _navigationService.popAndPushNamed(ExperimentalProductFormViewRoute);
  }
}
