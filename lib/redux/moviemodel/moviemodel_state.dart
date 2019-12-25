import 'package:meta/meta.dart';
import 'package:movie_app/data/model/moviemodel_data.dart';
import 'package:movie_app/data/model/page_data.dart';
import 'package:movie_app/redux/action_report.dart';

class MovieModelState {
  final Map<String,Map<String,MovieModel>> moviemodels;
  final MovieModel moviemodel;
  final Map<String, ActionReport> status;
  final Page page;


  MovieModelState({

    @required this.moviemodels,
    @required this.moviemodel,
    @required this.status,
    @required this.page,
  });

  MovieModelState copyWith({
    final Map<String,Map<String,MovieModel>> moviemodels,
    MovieModel moviemodel,
    Map<String, ActionReport> status,
    Page page,
  }) {
    return MovieModelState(
      moviemodels: moviemodels ?? this.moviemodels ?? Map(),
      moviemodel: moviemodel ?? this.moviemodel,
      status: status ?? this.status,
      page: page ?? this.page,
    );
  }
}
