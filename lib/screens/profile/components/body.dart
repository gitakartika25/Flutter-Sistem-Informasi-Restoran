import 'package:flutter/material.dart';
import 'package:resto_mobile/config/config_auth.dart';
import 'package:resto_mobile/screens/profile/components/profile_menu.dart';
import 'package:resto_mobile/screens/profile/components/profile_pic.dart';
import 'package:resto_mobile/screens/sign_in/sign_in_screen.dart';

class Body extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
    padding: EdgeInsets.symmetric(vertical: 100),
    child: Column(
      children: [
        ProfilePic(),
        SizedBox(height: 20),
        ProfileMenu(
          text: nameGoogle == "" || nameGoogle == null ? "Cashier" : nameGoogle,
          icon: "assets/icons/Heart Icon.svg",
          press: () => {},
        ),
        ProfileMenu(
          text: emailGoogle == "" || emailGoogle == null ? emailUser : emailGoogle,
          icon: "assets/icons/User.svg",
          press: () {},
        ),
        ProfileMenu(
          text: "Log Out",
          icon: "assets/icons/Log out.svg",
          press: () {
            showDeleteDialog(context);
            },
        ),
      ],
    ),);
  }
  showDeleteDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Logout Alert"),
      content: Text("Are you sure to LogOut?"),
      actions: [
        FlatButton(
          child: new Text('NO'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
            child: new Text("YES"),
            onPressed: () {
              signOutGoogle();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) {
                    return SignIn();
                  }), ModalRoute.withName('/sign_in'));
              }
            ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}