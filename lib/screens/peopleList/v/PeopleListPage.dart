import 'package:actors_profile/genericTools/provider/ProviderPeopleList.dart';
import 'package:actors_profile/genericUI/ColorProject.dart';
import 'package:actors_profile/genericUI/paginate/PaginateManagerGridview.dart';
import 'package:actors_profile/genericUI/paginate/m/ProviderPaginate.dart';
import 'package:actors_profile/genericUI/textStyle/TextStyleHelper.dart';
import 'package:actors_profile/screens/peopleList/m/DownloadDataPeople.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PeopleListPage extends StatefulWidget {


  @override
  PeopleListState createState() => PeopleListState();

}

class PeopleListState extends State<PeopleListPage> {

  //------------------------------------------------------------ variable

  ProviderPeopleList? provider ;
  bool progressStatus = false;

  //--------------------------------------------------------- life cycle

  @override
  initState() {
    super.initState();
    Log.i( "PeopleListState - initState() "  );
    startApiGet(1);
  }

  //------------------------------------------------------------ ui

  @override
  Widget build(BuildContext context) {
   Log.i( "PeopleListState - build() "  );

   return getMultiProvider(context);
  }

  //------------------------------------------------------------------------ provider

  Widget getMultiProvider(BuildContext context ) {
    return MultiProvider(providers:   [
      ChangeNotifierProvider.value(value:  ProviderPeopleList() ),
      ChangeNotifierProvider.value(value:  ProviderPaginate() )
    ],
      // child: getScaffold(),
      builder: ( contextProviderReaded, child){
        provider = Provider.of<ProviderPeopleList>( contextProviderReaded );
        providerPaginate = Provider.of<ProviderPaginate>(contextProviderReaded );


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
    return AppBar(
      title: Text("Popular People",
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

      paginateGridView( provider!.listWidget ),

      Positioned(child:  progressWidget(), top: 250, left: 0, right: 0,),
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

   Widget paginateGridView(List<Widget> children ) {
    return PaginateManagerGridview(
        children: children,
        grid_crossAxisCount: 3,
        grid_padding: 10,
        isAutoStartPageOne: false,
        callBack: (int newPage, bool progressStatus, bool isCompleted){

          Log.i( "paginateGridView() - newPage: " + newPage.toString() );

             startApiGet(newPage);
        }
    );
  }



}