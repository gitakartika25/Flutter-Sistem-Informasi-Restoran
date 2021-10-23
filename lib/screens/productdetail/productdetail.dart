import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  ProductDetail({Key key, this.document, this.status}) : super(key: key);
  bool status;
  QueryDocumentSnapshot<Object> document; // utnuk mendapatkan data pada cloud firestore

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int _n = 0;
  void add() {
    setState(() {
      _n++;
    });
  }

  void minus() {
    setState(() {
      if (_n != 0) _n--;
    });
  }

  @override
    void initState() {
      if (widget.status==true) {
        _n=widget.document['amount'];
      }
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Padding(
        padding: EdgeInsets.only(bottom: 30),
        child: Row(children: [
          Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 35, bottom: 20),
              child: SizedBox(
                width: 300,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                      child: Image.network(widget.document['images'],
                          fit: BoxFit.cover)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      padding: EdgeInsets.all(8),
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.orange)),
                      child: Image.network(
                        widget.document['images'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.orange)),
                      child: Image.network(
                        widget.document['images'],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ])
        ]),
      ),
      Container(
          width: double.infinity,
          height: 500,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(widget.document['title'],
                    style: Theme.of(context).textTheme.headline6),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 64),
                child: Text(widget.document['description']),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20, left: 200),
                child: Row(children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  SizedBox(
                    width: 40,
                    child: FloatingActionButton(
                      onPressed: add,
                      child: new Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        new Text('$_n', style: new TextStyle(fontSize: 30.0)),
                  ),
                  SizedBox(
                    width: 40,
                    child: new FloatingActionButton(
                      onPressed: minus,
                      child: new Icon(
                        Icons.remove,
                        color: Colors.black,
                      ),
                      backgroundColor: Colors.white,
                    ),
                  ),
                ]),
              ),
              widget.status != true ? Center(
                child: ElevatedButton(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                    child: Text("Add to Cart"),
                  ),
                  onPressed: (                    
                  ) {
                    // process add data in transaction
                    if (_n > 0){ // digunakan untuk merujuk ke collection yg akan digunakan
                      CollectionReference<Map<String, dynamic>> transaksi = FirebaseFirestore.instance.collection("transaction");
                    var data = { 
                      'images': widget.document['images'], // deklarasi untuk add to cart
                      'title': widget.document['title'],
                      'amount': _n,
                      'price': widget.document['price'],
                      'rating': widget.document['rating'],
                      'description': widget.document['description'],
                    };
                    transaksi.add(data); // menggunakan method add dengan mengirim parameter add
                    } 
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orangeAccent[700],
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ) : Center(
                child: ElevatedButton(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
                    child: Text("Update to Cart"),
                  ),
                  onPressed: () {
                  
                    // process update data in transaction
                    if (_n > 0){ // digunakan untuk merujuk ke collection yg akan digunakan
                      DocumentReference<Map<String, dynamic>> transaksi = FirebaseFirestore.instance.collection("transaction").doc(widget.document.id);
                    var data = { // deklarasi data
                      
                      'amount': _n,
                
                    };
                    transaksi.update(data); // dilakukan update dengan menggunakan parameter
                    } 
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orangeAccent[700],
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
            ],
          )),
    ]);
  }
}
