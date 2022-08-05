import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';

class ProviderPaginate extends ChangeNotifier {


  // var currentRecord = 0; //how many record now visible
  // var previousCounter = 0; //the previous counter size of list, before invoke the next page

  bool _loading = false;


  int _pageFuture = 0;
  int _totalRecord = 0;
  int _totalPage = 0;

  //true: means no need to continue download
  bool _isCompleteAllPages = false;

  //-------------------------------------------------------------------- setter and getter

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
  } //true: cause show progress circle


  int get pageFuture => _pageFuture;

  set pageFuture(int value) {
    _pageFuture = value;
  }

  int get totalRecord => _totalRecord;

  set totalRecord(int value) {
    _totalRecord = value;
  }

  bool get isCompleteAllPages => _isCompleteAllPages;

  set isCompleteAllPages(bool value) {
    _isCompleteAllPages = value;
  }

  int get totalPage => _totalPage;

  set totalPage(int value) {
    _totalPage = value;
  }

  //-------------------------------------------------------------------- public method

  void updateCounter({required int currentPage, required int totalPage, required int totalRecord }){
    //set values
    this.totalPage = totalPage;
    this.pageFuture = currentPage;
    this.totalRecord = totalRecord;


    //set value of completed
    if( currentPage >= totalPage ) {
      isCompleteAllPages = true;
    }

    //stop
    this.loading = false;

    //log
    Log.i( "updateCounter() - currentPage: " + currentPage.toString() );
    Log.i( "updateCounter() - totalPage: " + totalPage.toString() );
    Log.i( "updateCounter() - totalRecord: " + totalRecord.toString() );
    Log.i( "updateCounter() - isCompleteAllPages: " + isCompleteAllPages.toString() );

    notifyListeners();

    /**
        //what to do in in every case
        if( isCompleteAllPages ) {
        //focusToPosition( previousCounter);
        callBackComplete();
        } else {
        focusToFirstItemInNewPage();
        //progress end
        _progressEnd_waitForNextScroll();
        }

        //set previous
        // previousCounter = currentRecord;
     */

  }

}