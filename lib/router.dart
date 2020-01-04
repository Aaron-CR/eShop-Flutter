import 'package:eshop/screens/deals_screen.dart';
import 'package:eshop/screens/home_screen.dart';
import 'package:eshop/screens/product/add_product.dart';
import 'package:eshop/screens/product_details_screen.dart';
import 'package:eshop/screens/product_list_screen.dart';
import 'package:eshop/screens/profile_screen.dart';
import 'package:eshop/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const String initialRoute = '/';
const String homeRoute = '/home';
const String authenticateRoute = '/authenticate';
const String dealsRoute = '/deals';
const String profileRoute = '/my-account';
const String productListRoute = '/product-list';
const String productDetailsRoute = '/product-details';
const String addProductRoute = '/add-product';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => Wrapper());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case '/deals':
        return MaterialPageRoute(builder: (_) => DealsScreen());
      case '/my-account':
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case '/product-list':
        return MaterialPageRoute(builder: (_) => ProductListScreen());
      case '/addProduct':
        return MaterialPageRoute(builder: (_) => AddProduct());
      case '/productDetails':
        return MaterialPageRoute(builder: (_) => ProductDetailsScreen());
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
}
