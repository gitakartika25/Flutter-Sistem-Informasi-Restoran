import 'package:flutter/material.dart';
import 'package:resto_mobile/enum.dart';
import 'package:resto_mobile/screens/history/historyscreen.dart';
import 'package:resto_mobile/screens/home/home.dart';
import 'package:resto_mobile/screens/listmenu/listscreen.dart';
import 'package:resto_mobile/screens/profile/profile.dart';

import '../constants.dart';

class NavbarBottom extends StatelessWidget {
  const NavbarBottom({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = kPrimaryColor;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: MenuState.home == selectedMenu
                      ? Colors.red
                      : inActiveIconColor,),
                onPressed: () {Navigator.pushNamed(context, Home.routeName);}
              ),
              IconButton(
                icon: Icon(Icons.menu_book, color: MenuState.history == selectedMenu
                      ? Colors.red
                      : inActiveIconColor,),
                onPressed: () {Navigator.pushNamed(context, HistoryScreen.routeName);},
              ),
              IconButton(
                icon: Icon(Icons.add, color: MenuState.transaction == selectedMenu
                      ? Colors.red
                      : inActiveIconColor,),
                onPressed: () {Navigator.pushNamed(context, ListMenu.routeName);},
              ),
              IconButton(
                icon: Icon(Icons.account_circle_outlined, color: MenuState.profile == selectedMenu
                      ? Colors.red
                      : inActiveIconColor,),
                onPressed: () {Navigator.pushNamed(context, ProfileScreen.routeName);}
              ),
            ],
          )),
    );
  }
}