import 'package:actors_profile/genericUI/ColorProject.dart';
import 'package:actors_profile/genericUI/FontProject.dart';
import 'package:flutter/material.dart';

class TextStyleHelper {

  static TextStyle h_1() {
    return  TextStyle(
        color: ColorProject.orange,
        fontSize: 20,
        fontFamily : FontProject.khand_bold
    );
  }


  static TextStyle h_2() {
    return  TextStyle(
        color: ColorProject.black,
        fontSize: 18,
        fontFamily : FontProject.khand_regular
    );
  }


  static TextStyle h_2_backgroundDark() {
    return  TextStyle(
        color: ColorProject.white,
        fontSize: 18,
        fontFamily : FontProject.khand_regular
    );
  }

  static TextStyle h_3_backgroundDark() {
    return  TextStyle(
        color: ColorProject.white,
        fontSize: 15,
        fontFamily : FontProject.roboto_regular
    );
  }


}