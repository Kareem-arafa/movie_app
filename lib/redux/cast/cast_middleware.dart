import 'package:redux/redux.dart';
import 'package:movie_app/redux/action_report.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'package:movie_app/redux/cast/cast_action.dart';
import 'package:movie_app/data/model/cast_data.dart';
import 'package:movie_app/data/remote/cast_repository.dart';

List<Middleware<AppState>> createCastMiddleware([
  CastRepository _repository = const CastRepository(),
]) {

  final getCast = _createGetCasts(_repository);

  return [
    TypedMiddleware<AppState, GetCastAction>(getCast),
  ];
}

Middleware<AppState> _createGetCasts(
    CastRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {

    running(next, action);
    repository
        .getCasts(action.id)
        .then((data) {
      if (data.isNotEmpty) {
        print('data deliver Cast ');
        CastModel cast = CastModel.fromJson(data);
        print("middleware Cast : ${cast.casts[0].name}");
        next(SyncCastAction(castModel: cast));
      }
      completed(next, action);
    }).catchError((error) {
      print(error);
      catchError(next, action, error);
    });
  };
}


void catchError(NextDispatcher next, action, error) {
  next(CastStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.error,
          msg: "${action.actionName} is error;${error.toString()}")));
}

void completed(NextDispatcher next, action) {
  next(CastStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.complete,
          msg: "${action.actionName} is completed")));
}

void noMoreItem(NextDispatcher next, action) {
  next(CastStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.complete,
          msg: "no more items")));
}

void running(NextDispatcher next, action) {
  next(CastStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.running,
          msg: "${action.actionName} is running")));
}

void idEmpty(NextDispatcher next, action) {
  next(CastStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.error,
          msg: "Id is empty")));
}
