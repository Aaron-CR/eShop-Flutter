import 'package:flutter/material.dart';
import 'package:eshop/core/models/product_models.dart';
import 'package:eshop/constants/route_names.dart';
import 'package:eshop/views/account/account_view.dart';
import 'package:eshop/views/deals/deals_view.dart';
import 'package:eshop/views/home/home_view.dart';
import 'package:eshop/views/product_details/product_details_view.dart';
import 'package:eshop/views/product_form/experimental_product_form/experimental_product_form_view.dart';
import 'package:eshop/views/product_form/product_form_view.dart';
import 'package:eshop/views/product_list/product_list_view.dart';
import 'package:eshop/views/signin/signin_view.dart';
import 'package:eshop/views/signup/signup_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AccountViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: AccountView(),
      );
    case DealsViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: DealsView(),
      );
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(),
      );
    case ProductDetailsViewRoute:
      var product = settings.arguments as Product;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ProductDetailsView(
          product: product,
        ),
      );
    case ExperimentalProductFormViewRoute:
      var productToEdit = settings.arguments as Product;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ExperimentalProductFormView(
          edittingProduct: productToEdit,
        ),
      );
    case ProductFormViewRoute:
      var productToEdit = settings.arguments as Product;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ProductFormView(
          edittingProduct: productToEdit,
        ),
      );
    case ProductListViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ProductListView(),
      );
    case SignInViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignInView(),
      );
    case SignUpViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUpView(),
      );
    /* case ProductFormRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ProductFormView(),
      ); */
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
