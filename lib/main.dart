import 'package:actors_profile/genericTools/provider/ProviderPeopleList.dart';
import 'package:actors_profile/genericUI/ColorProject.dart';
import 'package:actors_profile/genericUI/paginate/m/ProviderPaginate.dart';
import 'package:actors_profile/screens/peopleList/v/PeopleListPage.dart';
import 'package:actors_profile/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(  MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return getTheme(context);
  }


  Widget getTheme(BuildContext context){

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: ColorProject.statusBarColorBackground, //
        ),
        child: getMaterialApp(context)
    );
  }

  MaterialApp getMaterialApp(BuildContext context)   {

    return MaterialApp(
        title: "Abdallah Actors",

        //status bar
        theme: ThemeData(
        appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.grey,
    ))),

        debugShowCheckedModeBanner: false,
        scrollBehavior: MyScrollTheme(),
        home :  getScaffold(context),
    );
  }


  Scaffold getScaffold(BuildContext context) {
    return Scaffold(
      // body: getMultiProvider(context),
      body: nextPage(),
      resizeToAvoidBottomInset: true , //fix keyboard when open
    );
  }

  Widget nextPage(){
    // return PeopleListPage();
    return SplashScreen();
  }

  //------------------------------------------------------------------------ provider

  // Widget getMultiProvider(BuildContext context ) {
  //   return MultiProvider(providers:   [
  //     // ChangeNotifierProvider.value(value:  ProviderPeopleList() ),
  //     // ChangeNotifierProvider.value(value:  ProviderPaginate() )
  //   ],
  //     child: nextPage(),
  //
  //   );
  // }

}


class MyScrollTheme extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
