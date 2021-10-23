// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:resto_mobile/routes.dart';
import 'package:resto_mobile/screens/splash/splash_screen.dart';
import 'package:resto_mobile/theme.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme(),
      debugShowCheckedModeBanner: false,
      title: 'Mobile Resto',
      initialRoute:  SplashScreen.routeName,
      routes: routes,
    );
  }
}