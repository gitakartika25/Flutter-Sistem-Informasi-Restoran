import 'package:flutter/material.dart';
import 'package:resto_mobile/components/navbar_bottom.dart';
import 'package:resto_mobile/screens/listmenu/tab_bar.dart';

import '../../enum.dart';

class ListMenu extends StatelessWidget {
  ListMenu({this.search});
  String search;
  static String routeName = "/menu";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          title: Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 100),
              child: Text("List Menu"),
            ),
          ]),
        ),
        body: TabMenu(size: size,search:search),
        bottomNavigationBar: NavbarBottom(selectedMenu: MenuState.transaction));
  }
}

