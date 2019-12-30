import 'package:redux/redux.dart';
import 'package:movie_app/redux/action_report.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'package:movie_app/redux/moviemodel/moviemodel_actions.dart';
import 'package:movie_app/data/model/moviemodel_data.dart';
import 'package:movie_app/data/remote/moviemodel_repository.dart';
import 'package:movie_app/data/model/page_data.dart';

List<Middleware<AppState>> createMovieModelMiddleware([
  MovieModelRepository _repository = const MovieModelRepository(),
]) {
  final getMovieModels = _createGetMovieModels(_repository);

  return [

    TypedMiddleware<AppState, GetMovieModelsAction>(getMovieModels),

  ];
}


Middleware<AppState> _createGetMovieModels(
    MovieModelRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    if (action.isRefresh) {
      store.state.moviemodelState?.page[action.type]?.currPage??=1;
      store.state.moviemodelState.moviemodels.clear();
    } else {
      var p = ++store.state.moviemodelState.page[action.type].currPage;
      if (p > ++store.state.moviemodelState.page[action.type].totalPage) {
        noMoreItem(next, action);
        return;
      }
    }
    repository
        .getNowMovieModelsList(store.state.moviemodelState?.page[action.type]?.currPage??1,action.type)
        .then((map) {
      if (map.isNotEmpty) {
        print("data deliver");
        var page = Page(
            currPage: map["page"],
            totalPage: map["total_pages"],
            totalCount: map["total_results"],);
        Map<String,Page> pageMap= {action.type:page};
        print(page.currPage.toString());

        List l = map["results"] ?? List();
        print(l.length);
       // var map1=Map.fromIterable(l,key: (v)=>v[0],value:(v)=> v[1]);
        List<MovieModel> list = l.map<MovieModel>((item) => new MovieModel.fromJson(item)).toList();

        print(list.length);
        next(SyncMovieModelsAction(page: pageMap, moviemodels: list,type: action.type));
      }
      completed(next, action);
    }
    ).catchError((error) {
      print(error);
      catchError(next, action, error);
    });
  };
}

void catchError(NextDispatcher next, action, error) {
  next(MovieModelStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.error,
          msg: "${action.actionName} is error;${error.toString()}")));
}

void completed(NextDispatcher next, action) {
  next(MovieModelStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.complete,
          msg: "${action.actionName} is completed")));
}

void noMoreItem(NextDispatcher next, action) {
  next(MovieModelStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.complete,
          msg: "no more items")));
}

void running(NextDispatcher next, action) {
  next(MovieModelStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.running,
          msg: "${action.actionName} is running")));
}

void idEmpty(NextDispatcher next, action) {
  next(MovieModelStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.error,
          msg: "Id is empty")));
}
