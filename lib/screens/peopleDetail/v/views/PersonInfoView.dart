import 'package:actors_profile/backend/model/MPeople.dart';
import 'package:actors_profile/backend/modelTools/MPeopleTools.dart';
import 'package:actors_profile/genericTools/network/ToolsAPI.dart';
import 'package:actors_profile/genericUI/ColorProject.dart';
import 'package:actors_profile/genericUI/DrawableProject.dart';
import 'package:actors_profile/screens/peopleDetail/v/PeopleDetailPage.dart';
import 'package:actors_profile/screens/peopleDetail/v/views/TextTitleAndValue.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/widgets.dart';

double personInfoView_height_frame = 130;

extension PersonInfoView on PeopleDetailState {
  Widget getPersonInfoBar() {
    //cardview
    return Container(
      child: _getContent(),
      height: personInfoView_height_frame,
      padding: EdgeInsets.all(10),
      decoration: BoarderHelper.bottom_line(
          radiusSize: 30,
          colorLine: ColorProject.gray,
          colorBackground: ColorProject.black_logo),
    );
  }


  Widget _getContent() {
    return Stack( children: [
      EmptyView.empty( DeviceTools.getWidth(context), 200 ),

      _photo() ,

      Positioned(child:  _columnDataUser(), left: 100 )
    ],);
  }

  Widget _photo(){
    double size = 80;

    return ImageViewTemplate(
      widthNeeded: size,
      heightNeeded: size,
      context: context ,
      radius_all: 20,
      assetAspectRatio: DrawableProject.images( "logo"),
      boxFit_background: BoxFit.cover,
      urlBackground: MPeopleTools.getImageUrl( provider!.getPeopleSmall()! ),
    );
  }


  Widget _columnDataUser(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      TextTitleAndValue( "Known", provider!.getPeopleSmall()!.knownForDepartment??""),
      TextTitleAndValue( "Adult", provider!.getPeopleSmall()!.adult!.toString() ),
      TextTitleAndValue( "Gender", getNameOfGendner() ),
      TextTitleAndValue( "Popularity", provider!.getPeopleSmall()!.popularity!.toString() ),

    ],);
  }

  String getNameOfGendner() {
    int v = provider!.getPeopleSmall()!.gender??0;
    if( v == 1 ) {
      return "Woman";
    } else {
      return "Man";
    }
  }


}
