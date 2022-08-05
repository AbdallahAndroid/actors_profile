import 'dart:async';
import 'dart:io';

import 'package:actors_profile/genericTools/route/RoutePage.dart';
import 'package:actors_profile/genericUI/ColorProject.dart';
import 'package:actors_profile/genericUI/DrawableProject.dart';
import 'package:actors_profile/genericUI/FontProject.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:need_resume/need_resume.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends ResumableState<SplashScreen> {


  //--------------------------------------------------------------------- next page

  Future waitForSplashScreen() async {

    var time =  2000 ;
    Timer(Duration(milliseconds: time), () {

      nextPage();

    });

  }

  void nextPage(){
    RoutePage.peopleListPage(context);
  }

  //------------------------------------------------------------------------ life cycle

  @override
  void initState()    {
    super.initState();
  //  Log.i( "SplashScreenState - initState()");

   waitForSplashScreen();

  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    onResume();
  }


  @override
  void onResume() {
    // TODO: implement onResume
    super.onResume();
  //  Log.i( "onResume() ");

  }

  //-----------------------------------------------------------------------build ui

  @override
  Widget build(BuildContext context) {

    return systemDeviceBar();
  }


  Widget systemDeviceBar() {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: ColorProject.gray,
        ),
        child: getScaffold()
    );
  }


  Widget getScaffold() {
    return Scaffold(
      body: contentPage(),

    );
  }

  Widget contentPage(){
    return Stack( children: [

      //all screen
      EmptyView.colored(
        DeviceTools.getWidth(context) ,
        DeviceTools.getHeight(context),
        ColorProject.blackTransparent
      ),

      Positioned(child: getImageLogo() , left: 0, right: 0, top: 100 ), //top: 100*1.5,

      Positioned(child: developerName() , bottom: 20, left: 0, right: 0 ),

       //test socket
     // testSocketNotification()
  ]);

  }

  Widget getImageLogo() {
    var size = 150*1.5;

    var image =    ImageViewTemplate(
        widthNeeded: size,
        heightNeeded: size,
        radius_all: 15,
        //width: 150*1.5, height: 77*1.5,
        assetAspectRatio:  DrawableProject.images( "logo"), context: context   );

    return image;

  }


  Widget developerName() {


    var text = Text(  "Developed By\nAbdallah Mahmoud",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 25.0,
           fontFamily:  FontProject.khand_bold,
            color: ColorProject.white,
            decoration: TextDecoration.none,                               // underline shape
            decorationColor: ColorProject.white, //underline color
        )
    );


    return Container(
      padding: const EdgeInsets.only( bottom: 20),
      alignment: Alignment.center,
      child: text,
    );
  }

  //-------------------------------------------------------------------- test socket view

  /**
      Widget testSocketNotification() {
      //check not empty
      if( EnvironmentConstant.isLive) {
      return EmptyView.zero();
      }

      var txt =  TextTemplate.t( "socket: " + socket.toString(),
      width: 300, height: 300, levelDS: LevelDS.l2, color: Colors.black);
      return Positioned(child: txt, bottom: 250);
      }
   */






}
