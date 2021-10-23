import 'package:flutter/material.dart';
import 'package:resto_mobile/models/Category.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: category.length,
        itemBuilder: (context, index) => Container(
          width: 80,
          child: InkWell(
            onTap: () {},
            child: Column(children: [
              Card(
                color: Colors.blue[50],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 4.0,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0),
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Image.asset(category[index].icon)),
                ),
              ),
              SizedBox(height: 15),
              Text(
                category[index].title,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 10,
                  color: Colors.grey,
                  fontFamily: "PoppinsBold",
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
