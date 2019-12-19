import 'package:meta/meta.dart';
import 'package:movie_app/data/model/moviemodel_data.dart';
import 'package:movie_app/redux/action_report.dart';
import 'package:movie_app/data/model/page_data.dart';

class GetMovieModelsAction {
  final String actionName = "GetMovieModelsAction";
  final bool isRefresh;

  GetMovieModelsAction({this.isRefresh});
}
class GetNowPlayingMovieModelsAction {
  final String actionName = "GetMovieModelsAction";
  final bool isRefresh;

  GetNowPlayingMovieModelsAction({this.isRefresh});
}

class GetMovieModelAction {
  final String actionName = "GetMovieModelAction";
  final int id;

  GetMovieModelAction({@required this.id});
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

  SyncMovieModelsAction({this.page, this.moviemodels});
}
class SyncNowPlayingMovieModelsAction {
  final String actionName = "SyncMovieModelsAction";
  final Page page;
  final List<MovieModel> moviemodels;

  SyncNowPlayingMovieModelsAction({this.page, this.moviemodels});
}

class SyncMovieModelAction {
  final String actionName = "SyncMovieModelAction";
  final MovieModel moviemodel;

  SyncMovieModelAction({@required this.moviemodel});
}

class CreateMovieModelAction {
  final String actionName = "CreateMovieModelAction";
  final MovieModel moviemodel;

  CreateMovieModelAction({@required this.moviemodel});
}

class UpdateMovieModelAction {
  final String actionName = "UpdateMovieModelAction";
  final MovieModel moviemodel;

  UpdateMovieModelAction({@required this.moviemodel});
}

class DeleteMovieModelAction {
  final String actionName = "DeleteMovieModelAction";
  final MovieModel moviemodel;

  DeleteMovieModelAction({@required this.moviemodel});
}

class RemoveMovieModelAction {
  final String actionName = "RemoveMovieModelAction";
  final int id;

  RemoveMovieModelAction({@required this.id});
}

