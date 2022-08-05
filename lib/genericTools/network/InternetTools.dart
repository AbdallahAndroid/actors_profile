import 'dart:async';

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetTools {

  static Future<bool> isConnected() async {
    //check if web
    if( DeviceTools.isPlatformWeb() ) {
     // Log.i("isConnected() - is web - stop");
      return true;
    }

    //check in mobile
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }


}