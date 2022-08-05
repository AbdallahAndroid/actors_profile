import 'package:actors_profile/genericTools/TimeTools.dart';
import 'package:actors_profile/genericTools/file/ToolsFile.dart';
import 'package:actors_profile/genericUI/dialog/MessageGeneralDialog.dart';
import 'package:actors_profile/genericUI/toast/ToastTools.dart';
import 'package:actors_profile/screens/ImageFullScreen/v/ImageFullScreen.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:http/http.dart' as http;

extension ImageSaveToStorageController on ImageFullScreenState {

  Future clickOnSaveImageToStorage() async {

    //progress
    setState(() {
      progressSavingImage = true;
    });

    //full path
    String directoryPath = await ToolsFile.getPathDirectory();
    String unique = TimeTools.getCurrentTimestamp().toString();
    String fullPath = directoryPath + "/image_" + unique + ".png";

    //download data
    await downloadDataOfImage( fullPath );
  }


  Future downloadDataOfImage(String fullPathStorage ) async {

    try {
      //http
      Uri uri = Uri.parse( widget.imageUrl );
      http.Response  response = await http.get(uri);
      String data = response.body;
      Log.i("downloadDataOfImage() - finish body - success: "  +  data );

      //step
      await _saveDataOfImageAtFileLocal( fullPathStorage, data);
    }catch ( e) {
      _networkFailed( "Failed" + e.toString() );
    }
  }


  Future _saveDataOfImageAtFileLocal(String fullPath, String dataImage )  async {

    //save
    await ToolsFile.saveFile( fullPath, dataImage);

    //test read
    await ToolsFile.readFile( fullPath );

    //success
    _networkSuccess(fullPath);
  }

  void _networkFailed(String msg) {
    //progress
    setState(() {
      progressSavingImage = false;
    });

    ToolsToast.i(context, msg);
  }



  void _networkSuccess(String fullPath) {
    //progress
    setState(() {
      progressSavingImage = false;
    });

    //ToolsToast.i(context, "Success save to path:\n" + fullPath);
    MessageGeneralDialog.success( context, "Save Image To Local", fullPath, ( b ){

    });
  }


}