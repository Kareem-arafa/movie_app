import 'package:movie_app/data/remote/movieDetails_repository.dart';
import 'package:movie_app/redux/MovieDetails/movieDetails_action.dart';
import 'package:movie_app/redux/action_report.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createMovieDetailsMiddleware([
  MovieDetailsRepository _repository = const MovieDetailsRepository(),
]) {
  final getMovieDetails = _createGetMovieDetails(_repository);

  return [
    TypedMiddleware<AppState, GetMovieDetailsAction>(getMovieDetails),
  ];
}

Middleware<AppState> _createGetMovieDetails(MovieDetailsRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);

    repository.getMovieDetails(action.id).then((item) {
      print(item.posterPath);
      next(SyncMovieDetailsAction(detailsModel: item));
      completed(next, action);
    }).catchError((error) {
      print(error);
      catchError(next, action, error);
    });
  };
}

void catchError(NextDispatcher next, action, error) {
  next(MovieDetailsStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.error,
          msg: "${action.actionName} is error;${error.toString()}")));
}

void completed(NextDispatcher next, action) {
  next(MovieDetailsStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.complete,
          msg: "${action.actionName} is completed")));
}

void noMoreItem(NextDispatcher next, action) {
  next(MovieDetailsStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.complete,
          msg: "no more items")));
}

void running(NextDispatcher next, action) {
  next(MovieDetailsStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.running,
          msg: "${action.actionName} is running")));
}

void idEmpty(NextDispatcher next, action) {
  next(MovieDetailsStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.error,
          msg: "Id is empty")));
}
