import 'package:actors_profile/backend/model/MPeople.dart';
import 'package:actors_profile/backend/response/ResponsePeopleDetail.dart';
import 'package:actors_profile/backend/response/ResponsePeopleImages.dart';
import 'package:actors_profile/screens/peopleDetail/v/views/ItemGalleryPeople.dart';
import 'package:flutter/widgets.dart';

class ProviderPeopleDetail extends ChangeNotifier {

  MPeople? _peopleSmall;
  // ResponsePeopleDetail? _peopleDetail;
  List<MProfileImage>? _listProfileImage;

  List<Widget> _listWidgetImage = [];

 //--------------------------------------------------------------------- setter/getter

  MPeople?  getPeopleSmall() => _peopleSmall;

  set peopleSmall(MPeople value) {
    _peopleSmall = value;
  }

  // ResponsePeopleDetail? get peopleDetail => _peopleDetail;
  //
  // set peopleDetail(ResponsePeopleDetail? value) {
  //   _peopleDetail = value;
  //   notifyListeners();
  // }


  set listProfileImage(List<MProfileImage> value) {
    _listProfileImage = value;

    mapListProfileToWidget();

    notifyListeners();
  }


  List<MProfileImage>? getListProfileImage() => _listProfileImage;

  List<Widget> get listWidgetImage => _listWidgetImage;

  set listWidgetImage(List<Widget> value) {
    _listWidgetImage = value;
  }

  //------------------------------------------------------------------------ map

  Future mapListProfileToWidget() async {
    List<Widget> listWidget = [];

    for( int i = 0 ; i < _listProfileImage!.length; i++ ) {
      MProfileImage mProfileImage = _listProfileImage![i];
      Widget w = ItemGalleryPeople( getPeopleSmall()! , mProfileImage);
      listWidget.add(w );
    }

    _listWidgetImage = listWidget;
  }



}