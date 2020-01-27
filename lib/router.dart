import 'package:eshop/screens/authenticate_screen.dart';
import 'package:eshop/screens/deals_screen.dart';
import 'package:eshop/screens/home_screen.dart';
import 'package:eshop/screens/product/add_product.dart';
import 'package:eshop/screens/product_details_screen.dart';
import 'package:eshop/screens/product_list_screen.dart';
import 'package:eshop/screens/account_screen.dart';
import 'package:eshop/screens/splash_screen.dart';
import 'package:eshop/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const String initialRoute = '/';
const String splashRoute = '/splash';
const String homeRoute = '/home';
const String authenticateRoute = '/authenticate';
const String dealsRoute = '/deals';
const String accountRoute = '/my-account';
const String productListRoute = '/product-list';
const String productDetailsRoute = '/product-details';
const String addProductRoute = '/add-product';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute(builder: (_) => Wrapper());
      case splashRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case authenticateRoute:
        return MaterialPageRoute(builder: (_) => AuthenticateScreen());
      case dealsRoute:
        return MaterialPageRoute(builder: (_) => DealsScreen());
      case accountRoute:
        return MaterialPageRoute(builder: (_) => AccountScreen());
      case productListRoute:
        return MaterialPageRoute(builder: (_) => ProductListScreen());
      case productDetailsRoute:
        return MaterialPageRoute(builder: (_) => ProductDetailsScreen());
      case addProductRoute:
        return MaterialPageRoute(builder: (_) => AddProduct());
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
