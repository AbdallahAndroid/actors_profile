import 'dart:convert';

import 'package:actors_profile/genericTools/constant/EnvironmentConstant.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:dio/dio.dart';


// import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'NetworkManagerHttp.dart';


// import 'package:http/http.dart';

/**
 *
 *   dio: ^4.0.4

 1- in navigate write
    <uses-permission navigate:name="navigate.permission.INTERNET"/>

 */

typedef NetworkDiocallback_dio = void Function(
    bool status, String msg, Map<String, dynamic> mapJson);

class NetworkManagerDio {
  static final tag = "NetworkManage";

  //--------------------------------------------------------------------------- variable

  String url = "";
  Map<String, dynamic> body = Map();
  Map<String, String> headers = Map();
  String? filePath;
  NetworkType? type;

  bool isEnableLogDioPretty = true;

  NetworkDiocallback_dio? callback_dio;

  //------------------------------------------------------------------------- types constructor

  NetworkManagerDio(String url,
      {Map<String, dynamic>? body,
      Map<String, String>? headers,
      String? filePath,
      NetworkType? type,
        bool? isEnableLogDioPretty ,  //PrettyDioLogger
      NetworkDiocallback_dio? callback}) {
    //set values
    this.url = url;
    this.type = type;
    this.filePath = filePath;


    //log
    isEnableLogDioPretty ??= EnvironmentConstant.isTest; //default take test enviroment
    this.isEnableLogDioPretty = isEnableLogDioPretty;

    //set body and header
    if (body != null) this.body = body;
    if (headers != null) this.headers = headers;

    //type call back listener
    if (callback != null) {
      this.callback_dio = callback;
      _initConstructor();
    } else {
      /**
       callback not need, now you need to call "getFutureData()" to take feature of "Future"
       */
    }
  }

  //------------------------------------------------------------------------- type Future listener

  /**
   call this if use "Future" in your page
   */

  Future getFutureData() async {
    //set values
    this.url = url;
    this.type = type;

    //set body and header
    if (body != null) this.body = body;
    if (headers != null) this.headers = headers;

    //constructor
    await _initConstructor();
  }

  //-------------------------------------------------------------------- init constructor

  Future _initConstructor() async {
    //edit headers
    headers = setDefaultHeader(headers);

    //set method type "POST" when have body
    if (type == null && this.body.length > 0) {
      this.type = NetworkType.post;

      //case no body here is Get
    } else if (type == null) {
      this.type = NetworkType.get;
    }

    //log now
    //Log.k(tag, "start() url: " + url);
    //Log.k( tag, "start() body: " + this.body.toString()  );
    // Log.k( tag, "start() method.type: " + type.toString()  );
    // Log.k( tag, "start() header: " + this.headers.toString()  );

    //choose type
    await chooseTypeToStart();
  }
  //----------------------------------------------------------------------- start

  Future chooseTypeToStart() async {
    if (type == NetworkType.file ||
        filePath != null ) {
      _file();
    } else if (type == NetworkType.post) {
      _post_dio();
    } else if (type == NetworkType.put) {
      _put();
    } else {
      _get();
    }
  }

  //--------------------------------------------------------------------------- post

  Future _post_dio() async {
    try {
      FormData form = FormData.fromMap(body);

      Dio _dio = Dio();

      //show request and response in beatful log
      if( isEnableLogDioPretty ) {
        _dio.interceptors.add(PrettyDioLogger(
          requestHeader: isEnableLogDioPretty,
          requestBody: isEnableLogDioPretty,
          responseBody: isEnableLogDioPretty,
        ));
      }


      Response response =
          await _dio.post(url, options: Options(headers: headers), data: form);
     //Log.k(tag, "_post_dio() - success: " + response.toString());

      //call back
      if (callback_dio != null) callback_dio!(true, "success", response.data);

      //return
      return response.data;
    } catch (e) {
      String msg = e.toString();
      if( isEnableLogDioPretty ) {
        Log.k(tag, "_post_dio() - e: " + msg);
      }
      if (callback_dio != null) callback_dio!(false, msg, Map());
    }

    return Map();
  }

  //--------------------------------------------------------------------------- put

  Future _put() async {
    try {
      // FormData form = FormData.fromMap(body);

      Dio _dio = Dio();

      //show request and response in beatful log
      if( isEnableLogDioPretty ) {
        _dio.interceptors.add(PrettyDioLogger(
          requestHeader: isEnableLogDioPretty,
          requestBody: isEnableLogDioPretty,
          responseBody: isEnableLogDioPretty,
        ));
      }


      Response response =
          await _dio.put(url, options: Options(headers: headers), data: body);
     // Log.k(tag, "_put() - success: " + response.toString());

      //call back
      if (callback_dio != null) callback_dio!(true, "success", response.data);

      //return
      return response.data;
    } catch (e) {
      String msg = e.toString();
       Log.k(tag, "_put() - e: " + msg);
      if (callback_dio != null) callback_dio!(false, msg, Map());
    }

    return Map();
  }

  //---------------------------------------------------------------------------- file

  Future _file() async {
    try {
      Log.k(tag, "_file() - filePath: " + filePath.toString() );


      //check not file
      if (ToolsValidation.isEmpty(filePath)) {
        if (callback_dio != null)
          callback_dio!(false, "filePath not found", Map());
        return;
      }

      //generate cloud path
    //  String fileName = ToolsFile.getFileNameWithoutExtenstion( filePath );

      //data
      var formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath!),
      });

      Dio _dio = Dio();

      //show request and response in beatful log
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: isEnableLogDioPretty,
        requestBody: isEnableLogDioPretty,
        responseBody: isEnableLogDioPretty,
      ));

      Response response = await _dio.post(url,
          options: Options(headers: headers), data: formData);
      Log.k(tag, "_file() - success: " + response.toString());

      //call back
      if (callback_dio != null) callback_dio!(true, "success", response.data);

      //return
      return response.data;
    } catch (e) {
      String msg = e.toString();
      Log.k(tag, "_file() - e: " + msg);
      if (callback_dio != null) callback_dio!(false, msg, Map());
    }
    return Map();
  }

  //--------------------------------------------------------------------------- get

  Future _get() async {
    var _dio = Dio();

    //show request and response in beatful log
    if( isEnableLogDioPretty ) {
      _dio.interceptors.add(PrettyDioLogger(
        requestHeader: isEnableLogDioPretty,
        requestBody: isEnableLogDioPretty,
        responseBody: isEnableLogDioPretty,
      ));
    }

    try {

      Response response = await _dio.get(url, options: Options(headers: headers));
      // Log.k( tag, "_get() - success: "  + response.toString()  );

      //call back
      if (callback_dio != null) callback_dio!(true, "success", response.data);
      //return
      return response.data;
    } catch (e) {
      String msg = e.toString();
      Log.k(tag, "_get() - e: " + msg);
      if (callback_dio != null) callback_dio!(false, msg, Map());
    }
    return Map();
  }

  //------------------------------------------------------------------------- header

  static Map<String, String> setDefaultHeader(Map<String, String>? custome) {
    /**
     * check already write another "Content-Type"
     */
    if (custome != null) {
      bool containAlready = custome.containsKey("Content-Type");
      if (containAlready) return custome;
    }

    //default
    /**
     * the "POSTMAN" already found content-type hidden header already send by default
     * so we need here to pass this "Content-Type"
     */
    custome ??= Map();
    custome["Content-Type"] = "application/json";
    return custome;
  }
}
