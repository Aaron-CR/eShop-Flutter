import 'package:eshop/constants/route_names.dart';
import 'package:eshop/core/base/base_view_model.dart';
import 'package:eshop/core/locator.dart';
import 'package:eshop/core/models/product_models.dart';
import 'package:eshop/core/services/authentication_service.dart';
import 'package:eshop/core/services/firestore_service.dart';
import 'package:eshop/core/services/navigation_service.dart';
import 'package:eshop/theme/theme.dart';
import 'package:eshop/views/product_details/product_details_view.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends BaseViewModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

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

  Future<void> signOut() async {
    await _authenticationService.signOut();
    await _navigationService.navigateTo(SignInViewRoute);
  }

  Future navigateToAccountView() async {
    await _navigationService.navigateTo(AccountViewRoute);
  }

  Future navigateToDealsView() async {
    await _navigationService.navigateTo(DealsViewRoute);
  }

  Future navigateToProductListView() async {
    await _navigationService.navigateTo(ProductListViewRoute);
  }

  Future navigateToProductDetailsView(int index) async {
    await _navigationService.navigateTo(ProductDetailsViewRoute,
        arguments: products[index]);
  }

  Future navigateToExperimentalProductFormView() async {
    await _navigationService.navigateTo(ExperimentalProductFormViewRoute);
  }
}

class DataSearch extends SearchDelegate<String> {
  final List<Product> listWords;

  DataSearch(this.listWords);

  @override
  List<Widget> buildActions(BuildContext context) {
    //Actions for app bar
    return [
      IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: transitionAnimation,
        ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    final suggestionList = listWords;

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: Text(listWords[index].productName),
        subtitle: Text(listWords[index].price.toString()),
      ),
      itemCount: suggestionList.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something

    final suggestionList = query.isEmpty
        ? listWords
        : listWords
            .where((p) =>
                p.productName.contains(RegExp(query, caseSensitive: false)))
            .toList();

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProductDetailsView(product: suggestionList[index]),
            ),
          );
        },
        trailing: Icon(Icons.arrow_forward_ios, size: 14.0),
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].productName.substring(0, query.length),
            style: TextStyle(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: suggestionList[index].productName.substring(query.length),
                style: TextStyle(color: Colors.black45),
              ),
            ],
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
