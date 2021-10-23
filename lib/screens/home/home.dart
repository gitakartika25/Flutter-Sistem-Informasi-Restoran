import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resto_mobile/screens/cart/cart_screen.dart';
import 'package:resto_mobile/components/navbar_bottom.dart';
import 'package:resto_mobile/screens/listmenu/listscreen.dart';
import '../../enum.dart';
import 'components/category.dart';
import 'components/discount.dart';
import 'components/grid_menu.dart';
import 'components/icon_btn_with_counter.dart';
import 'components/special_menu.dart';

class Home extends StatefulWidget {
  static String routeName = "/home";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference products = firestore.collection('products');

    return Scaffold(
      appBar: AppbarBuilder(context),
      body: ListView(
        children:[ Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                children: [
                  DiscountBanner(),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  Category(),
                  Padding(padding: EdgeInsets.only(top: 40)),
                  SpecialTextMenu(),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  SpecialMenu(),
                  SizedBox(height: 20),
                  Padding(padding: EdgeInsets.only(top: 20)),
                  PopularTextProducts(),
                  Padding(padding: EdgeInsets.only(top: 40)),
                  PopularProducts(),
                ],
              ),
            ),
          ],
        ),
      ]),
      bottomNavigationBar: NavbarBottom(selectedMenu: MenuState.home)
    );
  }

  PreferredSize AppbarBuilder(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(double.infinity, 90),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 120,
        child: Padding(
          padding: EdgeInsets.only(left: 10, top: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 280,
                height: 40,
                child: TextFormField(
                    controller: searchController,
                    enabled: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 1,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: "Search in Mamp Resto",
                      prefixIcon: InkWell(
                        child: Icon(
                          Icons.search,
                          color: Colors.grey[400],
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return ListMenu(search: searchController.text);
                              },
                            ),
                          );
                        },
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                          width: 1,
                          color: Colors.white,
                        ),
                      ),
                    )),
              ),
              SizedBox(
                width: 5,
              ),
              Spacer(),
              IconBtnWithCounter(
                svgSrc: "assets/icons/Cart Icon.svg",
                press: () => Navigator.pushNamed(context, CartScreen.routeName),
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}