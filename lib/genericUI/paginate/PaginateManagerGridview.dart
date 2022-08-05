import 'package:actors_profile/genericUI/paginate/c/PaginateController.dart';
import 'package:actors_profile/genericUI/paginate/v/PaginateView.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:provider/provider.dart';

import 'm/ProviderPaginate.dart';


//-------------------------------------------------------------------- public utils

typedef PaginateCallBack = Function(int newPage, bool progressStatus, bool isCompleted );

class PaginateConstant {
  static const  paginator = 20; //this app paginate is 20 "Actor Abdallah"
}

//-------------------------------------------------------------------- widget

class PaginateManagerGridview extends StatefulWidget {


  List<Widget> children = [];
  int? grid_crossAxisCount;
  double? grid_padding;
  PaginateCallBack callBack;

  bool isAutoStartPageOne = false; //true: cause on create page start callBack for first page

  PaginateManagerGridview({required this.children,
    required this.callBack,

    bool? isAutoStartPageOne,
    required this.grid_crossAxisCount,
    required this.grid_padding
  }){
    isAutoStartPageOne ??= false;
    this.isAutoStartPageOne = isAutoStartPageOne;
  }

  @override
  PaginateState createState() {
    Log.i("PaginateState - createState()");
    return PaginateState();
  }

}

class PaginateState  extends ResumableState<PaginateManagerGridview> {


  ProviderPaginate? provider;


  var scrollcontroller = ScrollController();

  //---------------------------------------------------------------------------- life cycfle

  void initState() {
    super.initState();
   Log.i("PaginateState - initState()");
  }

  @override
  Widget build(BuildContext context) {
   Log.i("PaginateState - build()");
    provider = Provider.of<ProviderPaginate>(context);
    listenerScroll();
    autoStartPageOneFunction();
   //providerChangeListener();

    return getBuildView();
  }

  //------------------------------------------------------------ progress

  void progressStart(){
    provider!.loading = true;
  }


  void progressEnd(){
    provider!.loading = false;
  }



}