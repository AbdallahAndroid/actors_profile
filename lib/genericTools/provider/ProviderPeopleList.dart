

import 'package:actors_profile/backend/model/MPeople.dart';
import 'package:actors_profile/genericUI/textStyle/TextStyleHelper.dart';
import 'package:actors_profile/screens/peopleList/v/views/ItemViewPeople.dart';
import 'package:flutter/material.dart';


class ProviderPeopleList extends ChangeNotifier {

  //--------------------------------------------------------------------- progress

  // bool _progressStatus = false;
  //
  // bool get progressStatus => _progressStatus;
  //
  // set progressStatus(bool value) {
  //   _progressStatus = value;
  //   notifyListeners();
  // }

  //--------------------------------------------------------------------- peopleList

  List<MPeople> _listPeople = [];

  List<MPeople> get listPeople => _listPeople;

  Future replaceListPeople(List<MPeople> value) async {
    _listPeople = value;
    await mapListObjectToListWidget();
    notifyListeners();
  }


  Future appendListPeople(List<MPeople> value) async {
    _listPeople.addAll( value);
    await mapListObjectToListWidget();
    notifyListeners();
  }

//--------------------------------------------------------------------- widget

  List<Widget> _listWidget = [];

  List<Widget> get listWidget => _listWidget;


  Future mapListObjectToListWidget() async  {

    List<Widget> listWidgetUpdated = [];
    int position = 0;
    for( MPeople m in listPeople ) {

      //set position
      m.position = position;
      position = position+1;

      //map
      Widget w = await _mapSingleModelToWidget(m );
      listWidgetUpdated.add( w );
    }

    _listWidget =  listWidgetUpdated;
  }

  Future<Widget> _mapSingleModelToWidget( MPeople m ) async {
    Widget w = ItemViewPeople( m  );
    return w;
  }


  List<Widget> getWidgetListDataTest() {
    List<Widget> ls = [];
    for( int i = 1 ; i <= 70 ; i++ ) {
      Widget w = Text( "" + i.toString(), style: TextStyleHelper.h_2() );
      ls.add( w );
    }
    return ls;
  }





}