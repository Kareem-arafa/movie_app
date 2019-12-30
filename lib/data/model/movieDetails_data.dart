import 'package:hive/hive.dart';

part 'movieAdapter.dart';

@HiveType()
class DetailsModel {
  @HiveField(0)
  String Overview;
  @HiveField(1)
  String Title;
  List<_Genres> Genres;
  @HiveField(3)
  String PosterPath;
  @HiveField(4)
  String BackdropPath;
  @HiveField(5)
  String ReleaseDate;
  @HiveField(6)
  num VoteAverage;
  @HiveField(7)
  int Id;

  DetailsModel.details();

  DetailsModel({
    this.BackdropPath,
    this.Id,
    this.Overview,
    this.PosterPath,
    this.ReleaseDate,
    this.Title,
    this.VoteAverage,
  });

  DetailsModel.fromJSON(Map<String, dynamic> parsedJson) {
    Id = parsedJson['id'] ?? 0;
    VoteAverage = parsedJson['vote_average'] ?? 0.0;
    ReleaseDate = parsedJson['release_date'] ?? "";
    BackdropPath = parsedJson['backdrop_path'] ?? '';
    PosterPath = parsedJson['poster_path'] ?? '';
    Title = parsedJson['title'] ?? '';
    Overview = parsedJson['overview'] ?? '';
    List<_Genres> temp = [];

    for (int i = 0; i < parsedJson['genres'].length; i++) {
      _Genres result = _Genres(parsedJson['genres'][i]);
      temp.add(result);
    }
    Genres = temp;
  }

  void addFavorite(DetailsModel detailsModel) {
    final favoriteBox = Hive.box('favoriteMovie');
    favoriteBox.add(detailsModel);
  }
//   Genres = parsedJson['genres']==null? []:parsedJson['genres'].cast<_Genres>().toList();
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
