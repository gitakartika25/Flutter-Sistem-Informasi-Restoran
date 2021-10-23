import 'package:flutter/material.dart';

import 'components/body_login_success.dart';

class LoginSuccessScreen extends StatelessWidget {
  static String routeName = "/log_in_success";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios, color: Colors.black), 
        onPressed: ()=>Navigator.pop(context)),
        title: Padding(
          padding: const EdgeInsets.only(left:70),
          child: Text("Login Success"),
        ),
      ),
      body: BodyLoginSuccess(),
    );
  }
}