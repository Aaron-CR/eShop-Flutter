import 'package:eshop/screens/authenticate/authenticate.dart';
import 'package:eshop/screens/deals_screen.dart';
import 'package:eshop/screens/product_list_screen.dart';
import 'package:eshop/screens/profile_screen.dart';
import 'package:flutter/material.dart';

import 'package:eshop/shared/constants_routes.dart';
import 'package:eshop/screens/authenticate/sign_in_screen.dart';
import 'package:eshop/screens/authenticate/sign_up_screen.dart';

var routes = <String, WidgetBuilder>{
  authenticateRoute: (context) => AuthenticateScreen(),
  signInRoute: (context) => SignInScreen(),
  signUpRoute: (context) => SignUpScreen(),
  dealsRoute: (context) => DealsScreen(),
  profileRoute: (context) => ProfileScreen(),
  productListRoute: (context) => ProductListScreen(),
};
