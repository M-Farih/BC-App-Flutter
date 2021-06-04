import 'package:flutter/material.dart';

class Style{

  /// colors
  static final Color primaryColor = Color(0xFF4382D8); //#4382D8
  static final Color secondaryColor = Color(0xFF2FACD6); //#2FACD6
  static final Color darkColor = Color(0xFF151515); //#151515
  static final List<Color> gradientColors = [primaryColor, secondaryColor]; //#151515

  /// Text style
  static final TextStyle appNameTextStyle =
  TextStyle(fontSize: 32, fontWeight: FontWeight.w500, color: Colors.white);

  ///Decorations
  static InputDecoration inputDecoration(String label){
    return InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white, style: BorderStyle.solid),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white),
        ),
        labelStyle: TextStyle(color: Colors.white)
    );
  }
}