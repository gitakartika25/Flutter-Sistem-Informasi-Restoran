//import 'dart:js';

import 'dart:ffi';

import 'package:flutter/widgets.dart';
import 'package:resto_mobile/screens/cart/cart_screen.dart';
import 'package:resto_mobile/screens/history/history.dart';
import 'package:resto_mobile/screens/history/historyscreen.dart';
import 'package:resto_mobile/screens/home/home.dart';
import 'package:resto_mobile/screens/listmenu/listscreen.dart';
import 'package:resto_mobile/screens/productdetail/product_detail_screen.dart';
import 'package:resto_mobile/screens/profile/profile.dart';

import 'package:resto_mobile/screens/sign_in/sign_in_screen.dart';
import 'package:resto_mobile/screens/splash/splash_screen.dart';
import 'package:resto_mobile/screens/struck/struck.dart';

import 'screens/sign_in/login_success.dart';
// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignIn.routeName: (context) => SignIn(),
  Home.routeName: (context) => Home(),
  ListMenu.routeName: (context) => ListMenu(),
  ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  HistoryScreen.routeName: (context) => HistoryScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  Struck.routeName: (context) => Struck(),
};
