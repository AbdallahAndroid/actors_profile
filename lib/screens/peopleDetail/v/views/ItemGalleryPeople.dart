import 'package:actors_profile/backend/model/MPeople.dart';
import 'package:actors_profile/backend/modelTools/MPeopleTools.dart';
import 'package:actors_profile/backend/response/ResponsePeopleImages.dart';
import 'package:actors_profile/genericTools/route/RoutePage.dart';
import 'package:actors_profile/genericUI/DrawableProject.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/widgets.dart';

class ItemGalleryPeople extends StatelessWidget {

  MPeople mPeople;
  MProfileImage mProfileImage;

  ItemGalleryPeople( this.mPeople, this.mProfileImage);

  BuildContext? context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return _photo();
  }


  Widget _photo(){
    double size = DeviceTools.getThirdWidth(context!);

    return ImageViewTemplate(
      widthNeeded: size,
      heightNeeded: size,
      context: context! ,
      radius_all: 20,
      assetAspectRatio: DrawableProject.images( "logo"),
      boxFit_background: BoxFit.cover,
      urlBackground: getUrlPhoto()  ,
      onPressed: (){
        RoutePage.photoFullScreen( context!, getUrlPhoto()??"" );
      },
    );
  }


  String? getUrlPhoto() {
    return MPeopleTools.getImageUrlByProfilePath(  mProfileImage.filePath );
  }



}