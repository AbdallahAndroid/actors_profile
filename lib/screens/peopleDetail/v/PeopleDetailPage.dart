import 'package:actors_profile/backend/model/MPeople.dart';
import 'package:actors_profile/genericUI/ColorProject.dart';
import 'package:actors_profile/genericUI/textStyle/TextStyleHelper.dart';
import 'package:actors_profile/screens/peopleDetail/m/DownloadDataSinglePeople.dart';
import 'package:actors_profile/screens/peopleDetail/m/ProviderPeopleDetail.dart';
import 'package:actors_profile/screens/peopleDetail/v/views/PersonInfoView.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../genericUI/paginate/m/ProviderPaginate.dart';

class PeopleDetailPage extends StatefulWidget {

  MPeople peopleSmall;

  PeopleDetailPage( this.peopleSmall);

  @override
  PeopleDetailState createState() => PeopleDetailState();

}

class PeopleDetailState extends State<PeopleDetailPage> {


  //------------------------------------------------------------ variable

  ProviderPeopleDetail? provider ;
  bool progressStatus = true;

  //--------------------------------------------------------- life cycle

  @override
  initState() {
    super.initState();
    startApiGetPersonImages();
  }

  //------------------------------------------------------------ ui

  @override
  Widget build(BuildContext context) {

    return getMultiProvider(context);
  }

  //------------------------------------------------------------------------ provider

  Widget getMultiProvider(BuildContext context ) {
    return MultiProvider(providers:   [
      ChangeNotifierProvider.value(value:  ProviderPeopleDetail() ),

    ],
      // child: getScaffold(),
      builder: ( contextProviderReaded, child){
        provider = Provider.of<ProviderPeopleDetail>( contextProviderReaded );

        provider!.peopleSmall = widget.peopleSmall;

        return getScaffold();
      },

    );
  }


  Widget getScaffold() {
    return Scaffold(
      appBar: getAppBar(),
      backgroundColor: ColorProject.white,
      // body: getContentScroll(),
      body: getContentBody(),
    );
  }


  AppBar getAppBar() {
    MPeople? mPeople = provider!.getPeopleSmall();

    return AppBar(
      title: Text( mPeople!.name??"",
        style: TextStyleHelper.h_1(),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: ColorProject.black,

    );
  }


  Widget getContentBody() {
    return Stack( children: [
      EmptyView.allDeviceScreen(context),

      getPersonInfoBar(),
      imagesGridView( provider!.listWidgetImage ),

      Positioned(child:  progressWidget(), left: 0, right: 0, top: personInfoView_height_frame + 20 ),
    ],);
  }


  Widget progressWidget() {
    //check no progress
    if( progressStatus == false  ) {
      return SizedBox(width: 0,);
    }
    var prg = ProgressSpinkit.get(context);
    return prg;
  }

  //--------------------------------------------------------------------- list

  ProviderPaginate? providerPaginate;

  Widget imagesGridView(List<Widget> children ) {
    var grid =  GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      children: children,
    );

    //space under the info of persond
    return Container(
      child: grid,
      margin: EdgeInsets.only(top: personInfoView_height_frame + 20 ),
    );
  }



}