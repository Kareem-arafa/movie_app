class DetailsModel {
  String _overview;
  String _title;
  List<_Genres> _genres;
  String _posterPath;
  String _backdropPath;
  String _releaseDate;
  num _voteAverage;
  int _id;

  DetailsModel.fromJSON(Map<String, dynamic> parsedJson) {
    _id = parsedJson['id']??0;
    _voteAverage = parsedJson['vote_average']??0.0;
    _releaseDate = parsedJson['release_date']??"";
    _backdropPath = parsedJson['backdrop_path']??'';
    _posterPath = parsedJson['poster_path']??'';
    _title = parsedJson['title']??'';
    _overview = parsedJson['overview']??'';
    List<_Genres> temp = [];

    for (int i = 0; i < parsedJson['genres'].length; i++) {
      _Genres result = _Genres(parsedJson['genres'][i]);
      temp.add(result);
    }

    _genres = temp??[];
  }

  String get overview => _overview;

  String get title => _title;

  String get posterPath => _posterPath;

  String get backdropPath => _backdropPath;

  String get releaseDate => _releaseDate;

  num get voteAverage => _voteAverage;

  List<_Genres> get genres => _genres;

  int get id => _id;
}

class _Genres {
  int _id;
  String _name;

  _Genres(genres) {
    _id = genres['id'];
    _name = genres['name'];
  }

  int get id => _id;

  String get name => _name;
}
