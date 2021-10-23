import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:resto_mobile/components/default_button.dart';
import 'package:resto_mobile/screens/home/home.dart';
import 'package:resto_mobile/screens/struck/components/body_struck.dart';

class Struck extends StatefulWidget {
  static String routeName = "/struck";
  Struck({Key key, this.idDocument, this.totalCheckout}) : super(key: key);
  String idDocument;
  int totalCheckout;

  @override
  _StruckState createState() => _StruckState();
}

class _StruckState extends State<Struck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Stack(
          children: <Widget>[
            ClipPath(
              clipper: OrangeClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 250.0,
                decoration: BoxDecoration(
                  color: Colors.orange,
                ),
              ),
            ),
            ClipPath(
              clipper: BlackClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width - 230.0,
                height: MediaQuery.of(context).size.height - 250.0,
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
              ),
            ),
            Center(
              child: Material(
                elevation: 30.0,
                color: Colors.white12,
                borderRadius: BorderRadius.circular(18.0),
                child: Container(
                  width: 320.0,
                  height: 250.0,
                  decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(18.0)),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: ClipPath(
                    clipper: ZigZagClipper(),
                    child: Container(
                      width: 330.0,
                      height: 400.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18.0)),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 30, left: 140, right: 100),
                            child: Text(
                              "Success!",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 50, left: 20),
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 35.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 57, left: 60),
                            child: Text(
                              'List Payment',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 90, left: 20, right: 20, bottom: 110),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                      color: Colors.grey, width: 1.0)),
                              child: StreamBuilder(
                                  // digunakan untuk menampilkan data dengan pengambilan berkala dan realtime
                                  stream: FirebaseFirestore.instance
                                      .collection('struk')
                                      .doc(widget.idDocument)
                                      .collection('strukdetail')
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return ListView(
                                        children:
                                            snapshot.data.docs.map((document) {
                                      // dilakukan pengambilan data pada saat mapping
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, right: 8, left: 8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(document['title']),
                                            Text(document['price'].toString() +
                                                " * " +
                                                document['amount'].toString() +
                                                "pcs")
                                          ],
                                        ),
                                      );
                                    }).toList());
                                  }),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 310, left: 130, right: 100),
                            child: Text(
                              "Total Amount",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 330, left: 145, right: 100),
                            child: Text(
                                "\Rp." + widget.totalCheckout.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange,
                                    fontSize: 16)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0,left: 30,right: 30),
                  
                  child: DefaultButton(
                    text: "Done",
                    press: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return Home();
                      }));
                    },
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Struck",
            style: TextStyle(color: Colors.black),
          ),
          // Text(
          //   "${demoCarts.length} items",
          //   style: Theme.of(context).textTheme.caption,
          // ),
        ],
      ),
    );
  }
}
