import 'package:actors_profile/genericUI/paginate/c/PaginateController.dart';
import 'package:actors_profile/genericUI/paginate/v/ShapeList.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';

import '../PaginateManagerGridview.dart';

extension PaginateView on PaginateState {

  Widget getBuildView( ) {
    return addTvMoreToGridview();
    // return _getGridview();

  }


  Widget  getGridview(List<Widget> editList){
    return  GridView.count(
      primary: false,  //vertical "true"
      padding:  EdgeInsets.all( widget.grid_padding??0),
      controller: scrollcontroller,
      crossAxisSpacing: widget.grid_padding??0,
      mainAxisSpacing: widget.grid_padding??0,
      crossAxisCount: widget.grid_crossAxisCount??2,
      children:  editList, // widget.children
    );
  }


}