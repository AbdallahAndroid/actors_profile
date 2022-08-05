import 'package:actors_profile/backend/BackendConstant.dart';
import 'package:actors_profile/backend/response/ResponsePeopleImages.dart';
import 'package:actors_profile/genericTools/network/NetworkManagerDio.dart';
import 'package:actors_profile/genericTools/network/NetworkManagerHttp.dart';
import 'package:actors_profile/genericUI/toast/ToastTools.dart';
import 'package:actors_profile/screens/peopleDetail/v/PeopleDetailPage.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

extension DownloadDataSinglePeople on PeopleDetailState {


  Future startApiGetPersonImages() async {
    progressStatus = true;

    await _apiNetworkListener();
  }


  Future _apiNetworkListener( ) async {

    /**
        https://api.themoviedb.org/3/person/1136406/images?api_key=ccccc
     */
    //url
    int personId = widget.peopleSmall.id!;
    String url = BackendConstant.baseUrl + "person/" + personId.toString()  +"/images?";
    url += "api_key=" + BackendConstant.apiKeyAuth;

    //network
    NetworkManagerDio(url,
        isEnableLogDioPretty : false,
        type: NetworkType.get, callback: (status, msg , json ) {

          if( status  ) {
            _parseData(json );
          } else {

            _failedNetwork(msg);

          }
        });

  }


  Future _parseData(Map<String, dynamic> json ) async  {

    //parse
    try {
      //  Log.i( "abdo - _apiNetwork() - json " + json.toString() );
      ResponsePeopleImages response = ResponsePeopleImages.fromJson( json );
      Log.i( "abdo - _parseData() - response.result.lenght: " + response.profiles!.length.toString() );

      //validate
      if( response.profiles == null ) {
        _failedNetwork( "No Data Found");
        return;
      }

      //set result
      _successDownloadData(response );


    } catch (e ){
      Log.i( "abdo - _apiNetwork() - catch e " + e.toString() );
      _failedNetwork( "Refresh the Page");
    }
  }

  void endProgress() {
    progressStatus = false;
  }

  void _successDownloadData(ResponsePeopleImages response  ) {

    //set data
    provider!.listProfileImage = response.profiles!;

    //end progress
    endProgress();
  }

  void _failedNetwork(String msg) {
    endProgress();
    ToolsToast.i(context, msg);
  }


}