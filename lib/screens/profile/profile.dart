import 'package:flutter/material.dart';
import 'package:resto_mobile/components/navbar_bottom.dart';

import '../../enum.dart';
import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 100),
          child: Text("Profile"),
        ),
      ),
      bottomNavigationBar: NavbarBottom(selectedMenu: MenuState.profile),
      body: Body(),
    );
  }
}