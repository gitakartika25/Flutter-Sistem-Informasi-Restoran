import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resto_mobile/screens/productdetail/productdetail.dart';


class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({this.document, this.status}); 
  bool status;
  QueryDocumentSnapshot<Object> document; // untuk mendapatkan data pada cloud firestore
  static String routeName = "/product_detail";  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios),
            onPressed: ()=>Navigator.pop(context),
            ),
      title: Row(
              children: [
                Padding(
            padding: const EdgeInsets.only(left:100),
            child: Text(document['rating'].toString()),
          ),
          Icon(Icons.star, color: Colors.yellow,),
              ]),
      ),
      body: ProductDetail(document:document, status:status),
    );

  }
}