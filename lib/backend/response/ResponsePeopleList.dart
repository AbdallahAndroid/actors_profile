import '../model/MPeople.dart';

class ResponsePeopleList {
  int? page;
  List<MPeople>? results;
  int? totalPages;
  int? totalResults;

  ResponsePeopleList(
      {this.page, this.results, this.totalPages, this.totalResults});

  ResponsePeopleList.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <MPeople>[];
      json['results'].forEach((v) {
       results!.add(new MPeople.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
    print( "abdo - ResponsePeopleList() - totalPages " + totalPages.toString() );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    return data;
  }

  @override
  String toString() {
    return 'ResponsePeopleList{page: $page, results: $results, totalPages: $totalPages, totalResults: $totalResults}';
  }
}

/**

    "adult": false,
    "gender": 1,
    "id": 224513,
    "known_for": [
    {
    "adult": false,
    "backdrop_path": "/sAtoMqDVhNDQBc3QJL3RF6hlhGq.jpg",
    "genre_ids": [
    878,
    18
    ],
    "id": 335984,
    "media_type": "movie",
    "original_language": "en",
    "original_title": "Blade Runner 2049",
    "overview": "Thirty years after the events of the first film, a new blade runner, LAPD Officer K, unearths a long-buried secret that has the potential to plunge what's left of society into chaos. K's discovery leads him on a quest to find Rick Deckard, a former LAPD blade runner who has been missing for 30 years.",
    "poster_path": "/gajva2L0rPYkEWjzgFlBXCAVBE5.jpg",
    "release_date": "2017-10-04",
    "title": "Blade Runner 2049",
    "video": false,
    "vote_average": 7.5,
    "vote_count": 10930
    },
   .....
    ],
    "known_for_department": "Acting",
    "name": "Ana de Armas",
    "popularity": 310.173,
    "profile_path": "/14uxt0jH28J9zn4vNQNTae3Bmr7.jpg"
    },
 */