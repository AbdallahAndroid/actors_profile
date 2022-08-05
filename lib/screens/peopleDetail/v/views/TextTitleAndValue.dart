import 'package:actors_profile/genericUI/textStyle/TextStyleHelper.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/widgets.dart';

class TextTitleAndValue extends StatelessWidget {

  String title;
  String value;

  TextTitleAndValue(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

      _titleTv(),
      SizedBox( width: 30,),
      _valueTv()
    ],);
  }


  Widget _titleTv(){
    var txt = Text( title + " : ", style: TextStyleHelper.h_2_backgroundDark()  );
    return Container( child:  txt, width: 100 ,);
  }


  Widget _valueTv(){
    return Text( value, style: TextStyleHelper.h_3_backgroundDark()  );
  }

}