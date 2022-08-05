import 'package:actors_profile/backend/model/MPeople.dart';
import 'package:actors_profile/backend/modelTools/MPeopleTools.dart';
import 'package:actors_profile/genericTools/constant/EnvironmentConstant.dart';
import 'package:actors_profile/genericTools/route/RoutePage.dart';
import 'package:actors_profile/genericUI/ColorProject.dart';
import 'package:actors_profile/genericUI/DrawableProject.dart';
import 'package:actors_profile/genericUI/textStyle/TextStyleHelper.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';


double itemPeople_size = 150;

class ItemViewPeople extends StatelessWidget {


  MPeople mPeople;

  ItemViewPeople( this.mPeople );

  BuildContext? context;

  @override
  Widget build(BuildContext context) {
    this.context = context;

    itemPeople_size = DeviceTools.getThirdWidth(context);

    //card
   var card =  BoarderHelper.cardViewPhysical(child: _getContent(), elevation_radius_value: 15);

   //space
   return Container( child: card,
    width: itemPeople_size,
    height: itemPeople_size,
    // margin: const EdgeInsets.only(top: 15 , left: 15, right: 15 ),
   );
  }


  Widget _getContent(){
    return Stack( children: [
      _photo(),

      Positioned(child:  barContentActor(), bottom: 0,)
    ],);
  }


  Widget barContentActor(){
    //shadow
    return Container( child: _name(),
      alignment: Alignment.center,
      color: ColorProject.blackTransparent,
      width: itemPeople_size,
      // padding: EdgeInsets.symmetric(vertical: 10),
    );
  }


  Widget _name() {

    String name = mPeople.name??"";
    if( EnvironmentConstant.isTest ) {
      name = mPeople.position.toString();
    }
    return Text(  name, style: TextStyleHelper.h_2_backgroundDark(),);
  }

  Widget _photo() {
    return ImageViewTemplate(context: context!,
        widthNeeded: itemPeople_size,
        heightNeeded: itemPeople_size,
      boxFit_background: BoxFit.cover,
      colorBackground: ColorProject.black_logo,
      assetAspectRatio: DrawableProject.images( "placeholder"),
      urlBackground: _getPhotoUrl(),
      onPressed: (){
        RoutePage.peopleDetailPage( context!, mPeople);
      },
    );
  }


  String? _getPhotoUrl(){
    if( EnvironmentConstant.isTest && mPeople.position != 2 ) return null;

    return MPeopleTools.getImageUrl(mPeople);
  }

}