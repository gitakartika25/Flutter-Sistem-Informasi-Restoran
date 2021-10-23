import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resto_mobile/screens/listmenu/listscreen.dart';
import 'package:resto_mobile/screens/productdetail/product_detail_screen.dart';

class PopularProducts extends StatefulWidget {
  @override
  _PopularProductsState createState() => _PopularProductsState();
}

class _PopularProductsState extends State<PopularProducts> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
        StreamBuilder( // mendapatkan data realtime
            stream:
                FirebaseFirestore.instance.collection('products').snapshots(), // merujuk pada suatu collection
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: snapshot.data.docs.map((document) { // dilakukan pengambilan data pada saat mapping
                  return InkWell(
                      child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: SizedBox(
                        width: 140,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AspectRatio(
                              aspectRatio: 1.02,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image:
                                            NetworkImage(document['images']),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              document['title'],
                              style: TextStyle(fontSize: 15),
                            ),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  document['price'].toString(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.orange),
                                ),
                                Container(
                                  padding: EdgeInsets.all(0),
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.orange[50],
                                    shape: BoxShape.circle,
                                  ),
                                  child:
                                      Icon(Icons.arrow_forward_ios, color: Colors. orange),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context){
                        return ProductDetailScreen(document: document);
                      })
                    );
                  },
                  );
                }).toList(),
              );
            }),
      ]),
    );
  }
}

class PopularTextProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        "Restaurant Products",
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          fontFamily: "PoppinsBold",
        ),
      ),
      Spacer(),
      GestureDetector(
        child: Text(
          "See all",
          style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              fontFamily: "PoppinsBold",
              color: Colors.grey),
        ),
        onTap: (){Navigator.pushNamed(
                        context, ListMenu.routeName);},
      ),
    ]);
  }
}
