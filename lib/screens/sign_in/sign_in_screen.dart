import 'package:flutter/material.dart';

import 'components/body_sign_in.dart';

class SignIn extends StatelessWidget {

  static String routeName = "/sign_in";  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios, color: Colors.black), 
        onPressed: ()=>Navigator.pop(context),),
        title: Padding(
          padding: const EdgeInsets.only(left:100),
          child: Text("Sign In"),
        ),
      ),
      body: Body(),
    );
  }
}