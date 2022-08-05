import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';

import '../PaginateManagerGridview.dart';

extension PaginateController  on PaginateState {

  //---------------------------------------------------------------- what to do after scroll

  /**
   * call when footer loading more data
   */
    whatToDoScrollDown()  {


    //check there is waiting loadding
    if(provider!.loading ) {
     Log.i( "whatToDoScrollDown() - stop cause by [loading]");
      return;
    }

     //check before refresh page
     if (mounted == false ){
      Log.i( "whatToDoScrollDown() - stop cause by [mounted == false]");
       return;
     }

     //downlaod system not start yet
     if( widget.children.length == 0 ) {
      Log.i( "whatToDoScrollDown() - stop cause by [totalRecord == 0]");
       return;
     }

    //check completed
    if( provider!.isCompleteAllPages ) {
     Log.i( "whatToDoScrollDown() - stop cause by [isCompleteAllPages]");
      return;
    }

    //there is record still waiting for scrolling
    Log.i( "whatToDoScrollDown() - callBackNextPage ");
     callBackNextPage();
  }

  //--------------------------------------------------------------------------- call back complete

   void callBackComplete(){
    // Log.i( "callBackComplete()   "  );
     provider!.isCompleteAllPages = true;

     //status complete
      progressEnd();
   }


   void callBackNextPage(){
    // Log.i( "callBackNextPage() ");
    //progress
     progressStart();

    //increment next page
     provider!.pageFuture = provider!.pageFuture + 1;

    //calll back
    widget.callBack( provider!.pageFuture, provider!.loading, provider!.isCompleteAllPages );
  }


  //-------------------------------------------------------------------------- auto start

  Future autoStartPageOneFunction() async {
    if( widget.isAutoStartPageOne == false )return;
    widget.isAutoStartPageOne = false; //prevent again

    callBackNextPage();
  }


    Future providerChangeListener() async {
      if( provider!.isCompleteAllPages )return;
      if( provider!.totalRecord == 0 ) return;

      Log.i( "providerChangeListener() - start");

      callBackNextPage();
    }
  //----------------------------------------------------------------------- focus

  Future focusToPosition(int position ) async {
   Log.i( "focusToPosition() - position: " + position.toString()
       + " /completed: " + provider!.isCompleteAllPages.toString()   + " /totalRecord: " + provider!.totalRecord.toString() );

   /**
    * //avoid exception:
       E/flutter (28856): [ERROR:flutter/lib/ui/ui_dart_state.cc(198)] Unhandled Exception: 'package:flutter/src/widgets/scroll_controller.dart': Failed assertion:
       line 107 pos 12: '_positions.isNotEmpty': ScrollController not attached to any scroll views.
    */
   if( position <= 0 ) return;


   // Get the full content height.
   final contentSize = scrollcontroller.position.viewportDimension + scrollcontroller.position.maxScrollExtent;
    Log.i( "focusToPosition() - contentSize: " + contentSize.toString()  );


   int currentRecord = provider!.totalRecord  ;
   final target = contentSize * position / currentRecord;
   Log.i( "focusToPosition() - target: " + target.toString()  );

   // Scroll to that position.
   scrollcontroller.position.animateTo(
     target,
     duration: const Duration(milliseconds: 300), //20000 -- slow   good
     curve: Curves.easeInOut,
   );
  }


  Future focusToFirstItemInNewPage() async {

    //first page not to focus to allow user see the above ads slider
    if( provider!.pageFuture == 1 ) return;

    //move down
    int totalRecord = widget.children.length;
    int previousRecordEndOn = totalRecord + (widget.grid_crossAxisCount! * 2 ); // - PaginateConstant.paginator;  - widget.grid_crossAxisCount!
    focusToPosition( previousRecordEndOn );
  }


    //------------------------------------------------------------------- listener



    void listenerScroll(){
      scrollcontroller.addListener(() {
        var isGoToBottom = scrollcontroller.position.pixels == scrollcontroller.position.maxScrollExtent;

        if (isGoToBottom) {
          Log.i( "listenerScroll() - isGoToBottom: " + isGoToBottom.toString() );
          whatToDoScrollDown();
        }

      });
    }



}


