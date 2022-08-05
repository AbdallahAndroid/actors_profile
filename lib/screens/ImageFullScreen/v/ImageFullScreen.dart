
import 'package:actors_profile/genericUI/ColorProject.dart';
import 'package:actors_profile/genericUI/textStyle/TextStyleHelper.dart';
import 'package:actors_profile/screens/ImageFullScreen/c/ImageSaveToStorageController.dart';

import 'package:extended_image/extended_image.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';



class ImageFullScreen extends StatefulWidget {
  String imageUrl;

  ImageFullScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  ImageFullScreenState createState() => ImageFullScreenState();
}

class  ImageFullScreenState extends State<ImageFullScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorProject.blackTransparent,
      appBar: AppBar(
        backgroundColor: ColorProject.black,
        title: Text(
          'Photo',
          style:  TextStyleHelper.h_1(),
        ),
        centerTitle: true,
        elevation: 0,
        leading: BackButton(color: Colors.black),
      ),
      body: pageContent(),
      floatingActionButton: buttonSaveToLocal(),
    );
  }


  Widget pageContent(){
    if( ToolsValidation.isEmpty( widget.imageUrl) ) {
      return errorBox();
    }
    if( widget.imageUrl.startsWith( "http") == false   ) {
      return errorBox();
    }

    return fullScreenImageSRC();
  }


  Widget errorBox(){
    // widget.imageUrl ??= "";

    return Container(
        decoration: cardDecoration(),
        height: DeviceTools.getHeight(context),
        alignment: Alignment.center,
        child: TextTemplate.t( "Image url not valid value: " + widget.imageUrl));
  }

  Widget fullScreenImageSRC(){
    return Container(
        decoration: cardDecoration(),
        height: DeviceTools.getHeight(context),
        child: ExtendedImage.network(
          widget.imageUrl,
          fit: BoxFit.contain,
          mode: ExtendedImageMode.gesture,
          initGestureConfigHandler: (state) {
            return gestureConfig();
          },
        ));
  }

  BoxDecoration cardDecoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(30)
        ));
  }


  GestureConfig gestureConfig() {
    return GestureConfig(
      minScale: 1,
      animationMinScale: 0.7,
      maxScale: 3.0,
      animationMaxScale: 3.5,
      speed: 1.0,
      inertialSpeed: 100.0,
      initialScale: 1.0,
      inPageView: false,
      initialAlignment: InitialAlignment.center,
    );
  }

  //--------------------------------------------------------------------- button save

  var progressSavingImage = false;

  Widget buttonSaveToLocal() {

    if(progressSavingImage) {
      return progressSavingImageView();
    }

    return ButtonTemplate.t( "Save", () async {
      Log.i( "save click");

      await clickOnSaveImageToStorage();

    });
  }

  Widget progressSavingImageView() {
    return Column( children: [
    ProgressSpinkit.get(context)
    ]) ;
  }



}
