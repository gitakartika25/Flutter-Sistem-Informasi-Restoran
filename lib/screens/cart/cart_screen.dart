import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:resto_mobile/components/default_button.dart';
import 'package:resto_mobile/screens/productdetail/product_detail_screen.dart';
import 'package:resto_mobile/screens/struck/struck.dart';
import 'package:intl/intl.dart';

import '../../constants.dart';
import '../../size_config.dart';

class CartScreen extends StatefulWidget {
  static String routeName = "/cart";

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController bayarController = new TextEditingController();
  int totalCheckout = 0;
  String totalBayar = "0";
  int totalPayment = 0;
  int lengthItem = 0;
  int lengthStruk = 0;
  DateTime now = DateTime.now();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection('struk').get().then((value) {
      value.docs.forEach((element) {
        lengthStruk += 1;
      });
    }); // untuk mencari jumlah data pd collection struk
    bayarController.text = bayarController.text;
    FirebaseFirestore.instance.collection('transaction/').get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          totalCheckout += element.get('amount') * element.get('price');
          lengthItem += 1;
          // bayarController.text  totalCheckuot ;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('transaction')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView(
                  children: snapshot.data.docs.map((document) {
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 88,
                        child: AspectRatio(
                          aspectRatio: 1.02,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: NetworkImage(document['images']),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          document['title'],
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          maxLines: 2,
                        ),
                        SizedBox(height: 10),
                        Text.rich(
                          TextSpan(
                            text: document['price'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: kPrimaryColor),
                            children: [
                              TextSpan(
                                  text: " x" + document['amount'].toString(),
                                  style: Theme.of(context).textTheme.bodyText1),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    InkWell(
                      child: Icon(Icons.edit),
                      onTap: () {
                        bool status = true;
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ProductDetailScreen(
                            document: document,
                            status: status,
                          );
                        })).then((value) {
                          totalCheckout = 0;
                          lengthItem = 0;
                          FirebaseFirestore.instance
                              .collection('transaction/')
                              .get()
                              .then((value) {
                            value.docs.forEach((element) {
                              setState(() {
                                totalCheckout += element.get('amount') *
                                    element.get('price');
                                lengthItem += 1;
                              });
                            });
                          });
                        });
                      },
                    ),
                    InkWell(
                      child: Icon(Icons.delete),
                      onTap: () {
                        print(document.id);
                        print(document['price']);
                        setState(() {
                          totalCheckout -=
                              document['amount'] * document['price'];
                          lengthItem -= 1;
                        });

                        var data = FirebaseFirestore.instance
                            .collection("transaction")
                            .doc(document.id);
                        data.delete();
                      },
                    ),
                  ],
                );
              }).toList());
            }),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenWidth(15),
          horizontal: getProportionateScreenWidth(30),
        ),
        // height: 174,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, -15),
              blurRadius: 20,
              color: Color(0xFFDADADA).withOpacity(0.15),
            )
          ],
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: getProportionateScreenWidth(40),
                    width: getProportionateScreenWidth(40),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset("assets/icons/receipt.svg"),
                  ),
                  Spacer(),
                  Container(
                    width: 250,
                    height: 40,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: bayarController,
                      onChanged: (v) => setState(() {
                        totalBayar = v;
                      }),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Mohon isi angka",
                        hintText: "Bayar",
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      ),
                    ),
                    // ),
                  ),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Total Products:\n",
                      children: [
                        TextSpan(
                          text: totalCheckout.toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(190),
                    child: DefaultButton(
                      text: "Check Out",
                      press: () { // digunakan untuk merujuk ke collection yang digunakan
                        CollectionReference<Map<String, dynamic>> strukDetail =
                            FirebaseFirestore.instance
                                .collection('struk')
                                .doc('struk' + lengthStruk.toString())
                                .collection('strukdetail');
                        DocumentReference<Map<String, dynamic>> struk =
                            FirebaseFirestore.instance
                                .collection('struk')
                                .doc('struk' + lengthStruk.toString()); // merujuk ke struk
                        FirebaseFirestore.instance
                            .collection('transaction/')
                            .get()
                            .then((value) { // mendapatkan data dari transaksi
                          value.docs.forEach((element) {
                            var data = { // digunakan untuk mengisi document field pada collection yang digunakan
                              'images':
                                  element.get('images'), // mengambil nilai
                              'title': element.get('title'),
                              'amount': element.get('amount'),
                              'price': element.get('price'),
                              'rating': element.get('rating'),
                              'description': element.get('description'),
                            };
                            strukDetail.add(data); // add data pada strukDetail
                          });
                        });
                        struk.set({ // membuat field struk
                          "id": 'struk' + lengthStruk.toString(),
                          "totalCheckout": totalCheckout,
                          "dateTime": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
                        });
                        FirebaseFirestore.instance // digunakan untuk merujuk ke collection yang digunakan
                            .collection('transaction/')
                            .get()
                            .then((value) {
                          value.docs.forEach((element) {
                            var data = FirebaseFirestore.instance
                                .collection("transaction")
                                .doc(element.id);
                            data.delete(); // dilakukan proses delete pada transaksi
                          });
                        });
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return Struck(
                              idDocument: "struk" + lengthStruk.toString(),
                              totalCheckout: totalCheckout);
                        }));
                      },
                    ),
                  ),
                ],
              ),
              Text("Kembalian:"),
              Text((int.parse(totalBayar) - totalCheckout).toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "${lengthItem} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
