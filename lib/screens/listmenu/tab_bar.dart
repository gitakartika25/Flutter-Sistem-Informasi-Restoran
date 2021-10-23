import 'package:flutter/material.dart';
import 'package:resto_mobile/screens/listmenu/product_grid_view.dart';


class TabMenu extends StatelessWidget {
  TabMenu({Key key, @required this.size, this.search}) : super(key: key);
  String search;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: <Widget>[
          TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.orange[900],
            tabs: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                child: Text("Food"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                child: Text("Drink"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                child: Text("Dessert"),
              ),
            ),
          ]),
          // PageListTitle(),
          SizedBox(
            height: 30,
          ),
          Expanded(
              child: TabBarView(children: [
            ProductGridView(
              size: size,
              category: "food",
              search: search,
            ),
            ProductGridView(size: size, category: "drink", search: search),
            ProductGridView(size: size, category: "dessert", search: search),
          ]))
        ],
      ),
    );
  }
}
