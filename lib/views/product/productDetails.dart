import 'package:bc_app/views/widgets/appbar.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final assetPath, title, description;
  final double price;

  ProductDetail(
      {this.assetPath,
      this.price,
      this.title,
      this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.arrow_back),
                    Text(
                      'المنتوجات',
                      style: TextStyle(fontSize: 20.0),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 1.4,
              width: MediaQuery.of(context).size.width - 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  //background color of box
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 25.0, // soften the shadow
                    spreadRadius: 1.0, //extend the shadow
                    offset: Offset(
                      1.0, // Move to right 10  horizontally
                      5.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 20.0),
                  Image.asset('$assetPath'),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          '$title',
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0),
                    child: Flexible(
                      child: Text(
                        '$description',
                        style: TextStyle(
                            fontSize: 10.0, fontWeight: FontWeight.normal),
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
