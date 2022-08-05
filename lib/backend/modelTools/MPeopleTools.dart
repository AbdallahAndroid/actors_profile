import 'package:actors_profile/backend/model/MPeople.dart';

class MPeopleTools {

  /**
   * full example
      https://image.tmdb.org/t/p/w500/bBRlrpJm9XkNSg0YT5LCaxqoFMX.jpg
   */
  static String? getImageUrl(MPeople m ) {
    return getImageUrlByProfilePath( m.profilePath);
  }

  static String? getImageUrlByProfilePath(String?  profilePath ) {
    if(  profilePath == null ) return null;

    String endPoint =  profilePath;
    return "https://image.tmdb.org/t/p/w500/" + endPoint;
  }

  // static String? getImageUrlCustomeWidth(MPeople m, int width ) {
  //   if( m.profilePath == null ) return null;
  //
  //   String endPoint = m.profilePath??"";
  //   return "https://image.tmdb.org/t/p/w" + width.toString() + endPoint;
  // }
}