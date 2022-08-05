
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';

class ToolsToast {

  static i(BuildContext context, String  msg ){



    //check empty
    if ( ToolsValidation.isEmpty( msg) ) return;
    Log.i( "ToastTools - i() - msg: " + msg );



    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );

  }


}
