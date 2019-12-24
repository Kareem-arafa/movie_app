import 'package:redux/redux.dart';
import 'package:movie_app/redux/action_report.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'package:movie_app/redux/trailer/trailer_action.dart';
import 'package:movie_app/data/model/trailler_data.dart';
import 'package:movie_app/data/remote/trailer_repository.dart';

List<Middleware<AppState>> createTrailerMiddleware([
  TrailersRepository _repository = const TrailersRepository(),
]) {

  final getTrailers = _createGetTrailers(_repository);

  return [
    TypedMiddleware<AppState, GetTrailersAction>(getTrailers),
  ];
}

Middleware<AppState> _createGetTrailers(
    TrailersRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {

    running(next, action);
    repository
       .getTrailers(action.id)
        .then((data) {
      if (data.isNotEmpty) {
        print('data deliver tailer ');
        TrailerModel list = TrailerModel.fromJson(data);
        print("middleware:");
        next(SyncTrailersAction(trailer: list));
      }
      completed(next, action);
    }).catchError((error) {
      print(error);
      catchError(next, action, error);
    });
  };
}


void catchError(NextDispatcher next, action, error) {
  next(TrailerStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.error,
          msg: "${action.actionName} is error;${error.toString()}")));
}

void completed(NextDispatcher next, action) {
  next(TrailerStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.complete,
          msg: "${action.actionName} is completed")));
}

void noMoreItem(NextDispatcher next, action) {
  next(TrailerStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.complete,
          msg: "no more items")));
}

void running(NextDispatcher next, action) {
  next(TrailerStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.running,
          msg: "${action.actionName} is running")));
}

void idEmpty(NextDispatcher next, action) {
  next(TrailerStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.error,
          msg: "Id is empty")));
}
