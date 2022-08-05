import 'package:actors_profile/backend/model/MPeople.dart';
import 'package:actors_profile/genericTools/route/NavigationTools.dart';
import 'package:actors_profile/screens/ImageFullScreen/v/ImageFullScreen.dart';
import 'package:actors_profile/screens/peopleList/v/PeopleListPage.dart';
import 'package:actors_profile/screens/peopleDetail/v/PeopleDetailPage.dart';
import 'package:flutter/material.dart';

class RoutePage {

  static peopleListPage(BuildContext context ) {
    NavigationTools.pushAndRemoveUntil(context, PeopleListPage() );
  }


  static peopleDetailPage(BuildContext context, MPeople mPeople ) {
    var page = PeopleDetailPage( mPeople );
    NavigationTools.push(context, page) ;
  }


  static photoFullScreen(BuildContext context, String imageUrl ) {
    var page = ImageFullScreen( imageUrl: imageUrl );
    NavigationTools.push(context, page) ;
  }

}