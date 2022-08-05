import 'package:actors_profile/backend/BackendConstant.dart';
import 'package:actors_profile/backend/model/MPeople.dart';
import 'package:actors_profile/backend/response/ResponsePeopleList.dart';
import 'package:actors_profile/genericTools/network/NetworkManagerDio.dart';
import 'package:actors_profile/genericTools/network/NetworkManagerHttp.dart';
import 'package:actors_profile/genericUI/toast/ToastTools.dart';
import 'package:actors_profile/screens/peopleList/v/PeopleListPage.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';

extension DownloadDataPeople on PeopleListState {

  Future startApiGet(int page) async {

    progressStatus =  true;

    _apiNetworkListener(page);
  }

  Future _apiNetworkListener(int page) async {

    //url
    String url = BackendConstant.baseUrl + "person/popular?";
    url += "api_key=" + BackendConstant.apiKeyAuth;
    url += "&page=" + page.toString();

   Log.i( "abdo - _apiNetwork() - page " + page.toString());

    //network
    NetworkManagerDio(url,
        isEnableLogDioPretty : false,
        type: NetworkType.get, callback: (status, msg , json ) {

      if( status  ) {
        _parseData(json, page);
      } else {

        _failedNetwork(msg);

      }
    });

  //  Log.i( "abdo - _apiNetwork() - end");
  }


  Future _parseData(Map<String, dynamic> json, int currentPage ) async  {

    //parse
    try {
    //  Log.i( "abdo - _apiNetwork() - json " + json.toString() );
      ResponsePeopleList response = ResponsePeopleList.fromJson( json );
      Log.i( "abdo - _apiNetwork() - response.result.lenght: " + response.results!.length.toString() );

      //validate
      if( response.results == null ) {
        _failedNetwork( "No Data Found");
        return;
      }

      //set result
      _successDownloadData(response , currentPage);


    } catch (e ){
      Log.i( "abdo - _apiNetwork() - catch e " + e.toString() );
      _failedNetwork( "Refresh the Page");
    }
  }

  void endProgress() {
    progressStatus = false;
  }

  void _successDownloadData(ResponsePeopleList response , int currentPage) {


    //appened
    if( currentPage == 1 ) {
      provider!.replaceListPeople (response .results!);
    } else {
      provider!.appendListPeople (response .results!);
    }

    //update counter paginate
    providerPaginate!.updateCounter(currentPage:  currentPage,
        totalPage: response.totalPages??1,
      totalRecord : provider!.listPeople.length
    );

    //end progress
    endProgress();
  }

  void _failedNetwork(String msg) {
    endProgress();
    ToolsToast.i(context, msg);
  }


}