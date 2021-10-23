import 'package:flutter/material.dart';
import 'package:resto_mobile/screens/home/home.dart';


class BodyLoginSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 90,
      ),
      GestureDetector(
        onTap: () {
                  Navigator.pushNamed(context, Home.routeName);
              },
              child: Container(
                height: 500,
                child: Image.asset(
          "assets/images/success.png",fit: BoxFit.cover,
        ),
              ),
      ),
    ]);
  }
}
