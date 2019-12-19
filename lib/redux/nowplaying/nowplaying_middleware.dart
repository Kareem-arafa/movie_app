import 'package:redux/redux.dart';
import 'package:movie_app/redux/action_report.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'package:movie_app/redux/nowplaying/nowplaying_actions.dart';
import 'package:movie_app/data/model/nowplaying_data.dart';
import 'package:movie_app/data/remote/nowplaying_repository.dart';
import 'package:movie_app/redux/nowplaying/nowplaying_actions.dart';
import 'package:movie_app/data/model/page_data.dart';

List<Middleware<AppState>> createNowPlayingMiddleware([
  NowPlayingRepository _repository = const NowPlayingRepository(),
]) {
  final getNowPlaying = _createGetNowPlaying(_repository);
  final getNowPlayings = _createGetNowPlayings(_repository);
  final createNowPlaying = _createCreateNowPlaying(_repository);
  final updateNowPlaying = _createUpdateNowPlaying(_repository);
  final deleteNowPlaying = _createDeleteNowPlaying(_repository);

  return [
    TypedMiddleware<AppState, GetNowPlayingAction>(getNowPlaying),
    TypedMiddleware<AppState, GetNowPlayingsAction>(getNowPlayings),
    TypedMiddleware<AppState, CreateNowPlayingAction>(createNowPlaying),
    TypedMiddleware<AppState, UpdateNowPlayingAction>(updateNowPlaying),
    TypedMiddleware<AppState, DeleteNowPlayingAction>(deleteNowPlaying),
  ];
}


Middleware<AppState> _createGetNowPlaying(
    NowPlayingRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {

    if (action.id == null) {
      idEmpty(next, action);
    } else {
      running(next, action);
      repository.getNowPlaying(action.id).then((item) {
        next(SyncNowPlayingAction(nowplaying: item));
        completed(next, action);
      }).catchError((error) {
        catchError(next, action, error);
      });
    }
  };
}

Middleware<AppState> _createGetNowPlayings(
    NowPlayingRepository repository) {
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
        .getNowPlayingsList(store.state.nowPlayingState.page.currPage)
        .then((map) {
      if (map.isNotEmpty) {
        var page = Page(
            currPage: map["page"],
            totalPage: map["total_pages"],
            totalCount: map["total_results"]);
        var l = map["results"] ?? List();
        List<NowPlaying> list =
            l.map<NowPlaying>((item) => new NowPlaying.fromJson(item)).toList();
        next(SyncNowPlayingsAction(page: page, nowplayings: list));
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

Middleware<AppState> _createCreateNowPlaying(
    NowPlayingRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
 //   if (checkActionRunning(store, action)) return;
    running(next, action);
    repository.createNowPlaying(action.nowplaying).then((item) {
      next(SyncNowPlayingAction(nowplaying: item));
      completed(next, action);
    }).catchError((error) {
      catchError(next, action, error);
    });
  };
}

Middleware<AppState> _createUpdateNowPlaying(
    NowPlayingRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
  //  if (checkActionRunning(store, action)) return;
    running(next, action);
    repository.updateNowPlaying(action.nowplaying).then((item) {
      next(SyncNowPlayingAction(nowplaying: item));
      completed(next, action);
    }).catchError((error) {
      catchError(next, action, error);
    });
  };
}

Middleware<AppState> _createDeleteNowPlaying(
    NowPlayingRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    //if (checkActionRunning(store, action)) return;
    running(next, action);
    repository.deleteNowPlaying(action.nowplaying.id).then((item) {
      next(RemoveNowPlayingAction(id: action.nowplaying.id));
      completed(next, action);
    }).catchError((error) {
      catchError(next, action, error);
    });
  };
}

/*bool checkActionRunning(Store<AppState> store, action) {
  if (store.state.photoState.status[action.actionName]?.status ==
      ActionStatus.running) {
    return true; // do nothing if there is a same action running.
  }
  return false;
}*/

void catchError(NextDispatcher next, action, error) {
  next(NowPlayingStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.error,
          msg: "${action.actionName} is error;${error.toString()}")));
}

void completed(NextDispatcher next, action) {
  next(NowPlayingStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.complete,
          msg: "${action.actionName} is completed")));
}

void noMoreItem(NextDispatcher next, action) {
  next(NowPlayingStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.complete,
          msg: "no more items")));
}

void running(NextDispatcher next, action) {
  next(NowPlayingStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.running,
          msg: "${action.actionName} is running")));
}

void idEmpty(NextDispatcher next, action) {
  next(NowPlayingStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.error,
          msg: "Id is empty")));
}
