import 'dart:convert';
import 'package:intl/intl.dart';

class UpComing {
  String overview;
  String originalLanguage;
  String originalTitle;
  bool video;
  String title;
  List<int> genreIds;
  String posterPath;
  String backdropPath;
  String releaseDate;
  num popularity;
  num voteAverage;
  int id;
  bool adult;
  int voteCount;

  UpComing({
    this.overview = "",
    this.originalLanguage = "",
    this.originalTitle = "",
    this.video = false,
    this.title = "",
    this.genreIds,
    this.posterPath = "",
    this.backdropPath = "",
    this.releaseDate = "",
    this.popularity = 0.0,
    this.voteAverage = 0.0,
    this.id = 0,
    this.adult = false,
    this.voteCount = 0,
  });

  UpComing.fromJson(Map<String, dynamic>  map) :
        overview = map['overview']  ?? "",
        originalLanguage = map['original_language']  ?? "",
        originalTitle = map['original_title']  ?? "",
        video = map['video']  ?? false,
        title = map['title']  ?? "",
        genreIds = map['genre_ids'] == null
            ? []
            : map['genre_ids'].cast<int>().toList(),
        posterPath = map['poster_path']  ?? "",
        backdropPath = map['backdrop_path']  ?? "",
        releaseDate = map['release_date']  ?? "",
        popularity = map['popularity']  ?? 0.0,
        voteAverage = map['vote_average']  ?? 0.0,
        id = map['id']  ?? 0,
        adult = map['adult']  ?? false,
        voteCount = map['vote_count']  ?? 0;

  Map<String, dynamic> toJson() => {
    'overview': overview,
    'original_language': originalLanguage,
    'original_title': originalTitle,
    'video': video,
    'title': title,
    'genre_ids': genreIds,
    'poster_path': posterPath,
    'backdrop_path': backdropPath,
    'release_date': releaseDate,
    'popularity': popularity,
    'vote_average': voteAverage,
    'id': id,
    'adult': adult,
    'vote_count': voteCount,
  };

  UpComing copyWith({
    String overview,
    String originalLanguage,
    String originalTitle,
    bool video,
    String title,
    List<int> genreIds,
    String posterPath,
    String backdropPath,
    String releaseDate,
    num popularity,
    num voteAverage,
    int id,
    bool adult,
    int voteCount,
  }) {
    return UpComing(
      overview: overview ?? this.overview,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalTitle: originalTitle ?? this.originalTitle,
      video: video ?? this.video,
      title: title ?? this.title,
      genreIds: genreIds ?? this.genreIds,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      releaseDate: releaseDate ?? this.releaseDate,
      popularity: popularity ?? this.popularity,
      voteAverage: voteAverage ?? this.voteAverage,
      id: id ?? this.id,
      adult: adult ?? this.adult,
      voteCount: voteCount ?? this.voteCount,
    );
  }
}
