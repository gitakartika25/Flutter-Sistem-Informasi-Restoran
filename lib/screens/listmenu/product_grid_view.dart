import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resto_mobile/screens/productdetail/product_detail_screen.dart';

import '../../constants.dart';

class ProductGridView extends StatelessWidget {
   ProductGridView({Key key, @required this.size, this.category, this.search})
      : super(key: key);

  final Size size;
  String category;
  String search;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').where('category', isEqualTo: category).where('title', isEqualTo: search).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: GridView.builder(
                itemCount: snapshot.data.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Container(
                        width: (size.width - 45) / 2,
                        height: (size.width - 45) / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage(
                                  snapshot.data.docs[index].get("images")
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        snapshot.data.docs[index].get("title"),
                        style: TextStyle(
                          fontSize: 14,
                          color: mScroudTextColor,
                        ),
                      ),
                      Text('Rp '+
                        snapshot.data.docs[index].get("price").toString(),
                        style: TextStyle(
                          color: mPrimaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                    onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context){
                        return ProductDetailScreen(document: snapshot.data.docs[index]);
                      })
                    );
                  },
                  );
                },
              ),
            ),
          );
        });
  }
}
