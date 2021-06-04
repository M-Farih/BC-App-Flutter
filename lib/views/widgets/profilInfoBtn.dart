import 'package:flutter/material.dart';

class ProfilInfoBtn extends StatelessWidget {

  final String text;
  final int color;
  final int textColor;
  final double btnHeight, btnWidth;

  ProfilInfoBtn({this.text, this.color, this.textColor, this.btnHeight, this.btnWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: btnHeight,//35
      width: btnWidth,//80
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
       borderRadius: BorderRadius.circular(50.0),
       border: Border.all(color: Color(0xFF1B7DBB))
     ),
    );
  }
}
