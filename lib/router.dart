import 'package:flutter/material.dart';
import 'package:eshop/core/models/product_models.dart';
import 'package:eshop/constants/route_names.dart';
import 'package:eshop/views/account/account_view.dart';
import 'package:eshop/views/deals/deals_view.dart';
import 'package:eshop/views/home/home_view.dart';
import 'package:eshop/views/product_details/product_details_view.dart';
import 'package:eshop/views/product_form/product_form_view.dart';
import 'package:eshop/views/product_list/product_list_view.dart';
import 'package:eshop/views/signin/signin_view.dart';
import 'package:eshop/views/signup/signup_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignInView(),
      );
    case SignUpViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUpView(),
      );
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(),
      );
    case CreateProductViewRoute:
      var productToEdit = settings.arguments as Product;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ProductFormView(
          edittingProduct: productToEdit,
        ),
      );
    case ProductDetailsRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ProductDetailsView(),
      );
    case AccountRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: AccountView(),
      );
    case DealsRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: DealsView(),
      );
    case ProductListRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ProductListView(),
      );
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
