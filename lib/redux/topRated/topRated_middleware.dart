import 'package:redux/redux.dart';
import 'package:movie_app/redux/action_report.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'package:movie_app/redux/topRated/topRated_action.dart';
import 'package:movie_app/data/model/topRated_data.dart';
import 'package:movie_app/data/remote/topRated_repository.dart';
import 'package:movie_app/data/model/page_data.dart';

List<Middleware<AppState>> createTopRatedMiddleware([
  TopRatedRepository _repository = const TopRatedRepository(),
]) {

  final getTopRateds = _createGetTopRateds(_repository);

  return [
    TypedMiddleware<AppState, GetTopRatedsAction>(getTopRateds),
  ];
}

Middleware<AppState> _createGetTopRateds(
    TopRatedRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {

    running(next, action);
    if (action.isRefresh) {
      store.state.nowPlayingState.page.currPage = 1;
      store.state.nowPlayingState.nowplayings.clear();
    } else {
      var p = ++store.state.nowPlayingState.page.currPage;
      if (p > ++store.state.nowPlayingState.page.totalPage) {
        noMoreItem(next, action);
        return;
      }
    }
    repository
        .getMovieModelsList(store.state.nowPlayingState.page.currPage)
        .then((map) {
      if (map.isNotEmpty) {
        var page = Page(
            currPage: map["page"],
            totalPage: map["total_pages"],
            totalCount: map["total_results"]);
        var l = map["results"] ?? List();
        List<TopRated> list =
        l.map<TopRated>((item) => new TopRated.fromJson(item)).toList();
        next(SyncTopRatedsAction(page: page, topRateds: list));
      }
      completed(next, action);
    }).catchError((error) {
      print(error);
      catchError(next, action, error);
    });
//    repositoryDB
//        .getNowPlayingsList(
//            "id",
//            store.state.nowplayingState.page.pageSize,
//            store.state.nowplayingState.page.pageSize *
//                store.state.nowplayingState.page.currPage)
//        .then((map) {
//      if (map.isNotEmpty) {
//        var page = Page(currPage: store.state.nowplayingState.page.currPage + 1);
//        next(SyncNowPlayingsAction(page: page, nowplayings: map));
//        completed(next, action);
//      }
//    }).catchError((error) {
//      catchError(next, action, error);
//    });
  };
}


void catchError(NextDispatcher next, action, error) {
  next(TopRatedStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.error,
          msg: "${action.actionName} is error;${error.toString()}")));
}

void completed(NextDispatcher next, action) {
  next(TopRatedStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.complete,
          msg: "${action.actionName} is completed")));
}

void noMoreItem(NextDispatcher next, action) {
  next(TopRatedStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.complete,
          msg: "no more items")));
}

void running(NextDispatcher next, action) {
  next(TopRatedStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.running,
          msg: "${action.actionName} is running")));
}

void idEmpty(NextDispatcher next, action) {
  next(TopRatedStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.error,
          msg: "Id is empty")));
}
