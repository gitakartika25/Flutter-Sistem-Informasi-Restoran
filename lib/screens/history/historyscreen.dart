import 'package:flutter/material.dart';
import 'package:resto_mobile/components/navbar_bottom.dart';
import 'package:resto_mobile/screens/history/history.dart';

import '../../enum.dart';


class HistoryScreen extends StatelessWidget {
  static String routeName = "/history";  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(children: [
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Text("History Transaction"),
          ),
        ]),
      ),
      body: History(),
      bottomNavigationBar: NavbarBottom(selectedMenu: MenuState.history)
    );
  }
}
