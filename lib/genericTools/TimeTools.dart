import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_browser.dart';
import 'package:flutter/material.dart';


class TimeTools {


  //----------------------------------------------------------------- current time

  /**
   * https://stackoverflow.com/a/62233947/7186671
   * 1654721784
   * 1654732024000
   */
  static int getCurrentTimestamp() {
    int numberWith1000 =  new DateTime.now().millisecondsSinceEpoch;
    String num_str = numberWith1000.toString();
    int len = num_str.length;
    String cut1000 =  num_str.substring( 0 , len- 3 );
    return int.parse( cut1000 );
  }





}