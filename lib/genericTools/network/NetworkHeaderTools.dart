import 'dart:convert';

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

class NetworkHeaderTools {

  /**
   * How to use ?
      var basicAuth = NetworkHeaderTools.basicAuth_usernameAndPassword( PayPalConstant.clientId, PayPalConstant.secret);
      header["Authorization"] = basicAuth;
   */
  static String basicAuth_usernameAndPassword(String username, String password ) {
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    Log.i( "basicAuth_usernameAndPassword() - basicAuth: " + basicAuth );

    return basicAuth;
  }


  static Map<String, String > bearerToken(String token ) {
    Map<String, String > header = Map();
    header[ "Authorization"] =  "Bearer " + token;
    return header;
  }

}