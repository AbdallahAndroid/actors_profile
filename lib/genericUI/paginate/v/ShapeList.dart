import 'package:actors_profile/genericUI/paginate/PaginateManagerGridview.dart';
import 'package:actors_profile/genericUI/paginate/c/PaginateController.dart';
import 'package:actors_profile/genericUI/paginate/v/PaginateView.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';

extension MoreDataLoading on PaginateState {

//------------------------------------------------------------ listview

  Widget addTvMoreToGridview(){
    //add children of itemlist
    List<Widget> editList = [];
    for( int i = 0 ; i < widget.children.length ; i++ ) {
      Widget w = widget.children[i];
      editList.add( w );
    }

    //add load more
    editList.add( tv_loadMore() );

    //view
    return getGridview(   editList );
  }



  Widget tv_loadMore(){
    //check not completed or not start yet
    if( provider!.isCompleteAllPages ||
        provider!.pageFuture == 0
    ) {
      return EmptyView.zero();
    }

    //view
    return TextTemplate.t( "Load More"  ,
        padding: const EdgeInsets.all(5),
        levelDS: LevelDS.l3,
        onPressed: (){
          whatToDoScrollDown();
        });
  }
}