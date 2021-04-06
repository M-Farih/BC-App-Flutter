import 'package:flutter/material.dart';

class ProfilInfoBtn extends StatelessWidget {

  final String text;
  final int color;
  final int textColor;

  ProfilInfoBtn({this.text, this.color, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.0,
      width: 80.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$text',
            style: TextStyle(
                fontSize: 18.0,
              color: Color(textColor)
            ),textDirection: TextDirection.rtl,
          ),
        ],
      ),
     decoration: BoxDecoration(
       color: Color(color),
       borderRadius: BorderRadius.circular(50.0)
     ),
    );
  }
}
