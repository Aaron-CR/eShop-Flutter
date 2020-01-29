import 'package:eshop/models/product_models.dart';
import 'package:eshop/old-model/screens/account_screen.dart';
import 'package:eshop/old-model/screens/product_details_screen.dart';
import 'package:eshop/ui/views/create_product_view.dart';
import 'package:eshop/ui/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:eshop/constants/route_names.dart';
import 'package:eshop/ui/views/signin_view.dart';
import 'package:eshop/ui/views/signup_view.dart';

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
        viewToShow: CreateProductView(
          edittingProduct: productToEdit,
        ),
      );
    case ProductDetailsRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ProductDetailsScreen(),
      );
    case AccountRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: AccountScreen(),
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
