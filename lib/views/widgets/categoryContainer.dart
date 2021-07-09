import 'package:flutter/material.dart';

class CategoryContainer extends StatelessWidget {
  final String imgUrl, text;
  final int color;

  CategoryContainer({this.imgUrl, this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 150.0,
          height: 150.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              //background color of box
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                blurRadius: 15.0, // soften the shadow
                spreadRadius: 1.0, //extend the shadow
                offset: Offset(
                  1.0, // Move to right 10  horizontally
                  5.0, // Move to bottom 10 Vertically
                ),
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                '$imgUrl',
                height: 60.0,
                width: 60.0,
                scale: 0.1,
              ),
              Text(
                '$text',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    color: Color(color),
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0),
              )
            ],
          ),
        ),
      ],
    );
  }
}
