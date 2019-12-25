import 'package:meta/meta.dart';
import 'package:movie_app/data/model/moviemodel_data.dart';
import 'package:movie_app/redux/action_report.dart';
import 'package:movie_app/data/model/page_data.dart';

class GetMovieModelsAction {
  final String actionName = "GetMovieModelsAction";
  final bool isRefresh;
  final String type;
  GetMovieModelsAction({this.isRefresh,this.type});
}


class MovieModelStatusAction {
  final String actionName = "MovieModelStatusAction";
  final ActionReport report;

  MovieModelStatusAction({@required this.report});
}

class SyncMovieModelsAction {
  final String actionName = "SyncMovieModelsAction";
  final Page page;
  final List<MovieModel> moviemodels;
  final String type;

  SyncMovieModelsAction({this.page, this.moviemodels,this.type});
}





