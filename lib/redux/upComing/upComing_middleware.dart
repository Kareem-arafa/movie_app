import 'package:redux/redux.dart';
import 'package:movie_app/redux/action_report.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'package:movie_app/redux/upComing/upComing_action.dart';
import 'package:movie_app/data/model/upComing_data.dart';
import 'package:movie_app/data/remote/upComing_repository.dart';
import 'package:movie_app/data/model/page_data.dart';

List<Middleware<AppState>> createUpComingMiddleware([
  UpComingRepository _repository = const UpComingRepository(),
]) {

  final getUpComings = _createGetUpComings(_repository);

  return [
    TypedMiddleware<AppState, GetUpComingsAction>(getUpComings),
  ];
}

Middleware<AppState> _createGetUpComings(
    UpComingRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {

    running(next, action);
    if (action.isRefresh) {
      store.state.upComingState.page.currPage = 1;
      store.state.upComingState.upComings.clear();
    } else {
      var p = ++store.state.upComingState.page.currPage;
      if (p > ++store.state.upComingState.page.totalPage) {
        noMoreItem(next, action);
        return;
      }
    }
    repository
        .getMovieModelsList(store.state.upComingState.page.currPage)
        .then((map) {
      if (map.isNotEmpty) {
        var page = Page(
            currPage: map["page"],
            totalPage: map["total_pages"],
            totalCount: map["total_results"]);
        var l = map["results"] ?? List();
        List<UpComing> list =
        l.map<UpComing>((item) => new UpComing.fromJson(item)).toList();
        next(SyncUpComingsAction(page: page, upComings: list));
      }
      completed(next, action);
    }).catchError((error) {
      print(error);
      catchError(next, action, error);
    });
};
}


void catchError(NextDispatcher next, action, error) {
  next(UpComingStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.error,
          msg: "${action.actionName} is error;${error.toString()}")));
}

void completed(NextDispatcher next, action) {
  next(UpComingStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.complete,
          msg: "${action.actionName} is completed")));
}

void noMoreItem(NextDispatcher next, action) {
  next(UpComingStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.complete,
          msg: "no more items")));
}

void running(NextDispatcher next, action) {
  next(UpComingStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.running,
          msg: "${action.actionName} is running")));
}

void idEmpty(NextDispatcher next, action) {
  next(UpComingStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.error,
          msg: "Id is empty")));
}
