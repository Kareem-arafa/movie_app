import 'package:redux/redux.dart';
import 'package:movie_app/redux/action_report.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'package:movie_app/redux/moviemodel/moviemodel_actions.dart';
import 'package:movie_app/data/model/moviemodel_data.dart';
import 'package:movie_app/data/remote/moviemodel_repository.dart';
import 'package:movie_app/redux/moviemodel/moviemodel_actions.dart';
import 'package:movie_app/data/model/page_data.dart';

List<Middleware<AppState>> createMovieModelMiddleware([
  MovieModelRepository _repository = const MovieModelRepository(),
]) {
  final getMovieModel = _createGetMovieModel(_repository);
  final getMovieModels = _createGetMovieModels(_repository);
  final createMovieModel = _createCreateMovieModel(_repository);
  final updateMovieModel = _createUpdateMovieModel(_repository);
  final deleteMovieModel = _createDeleteMovieModel(_repository);

  return [

    TypedMiddleware<AppState, GetMovieModelAction>(getMovieModel),
    TypedMiddleware<AppState, GetMovieModelsAction>(getMovieModels),
    TypedMiddleware<AppState, CreateMovieModelAction>(createMovieModel),
    TypedMiddleware<AppState, UpdateMovieModelAction>(updateMovieModel),
    TypedMiddleware<AppState, DeleteMovieModelAction>(deleteMovieModel),
  ];
}


Middleware<AppState> _createGetMovieModel(
    MovieModelRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action.id == null) {
      idEmpty(next, action);
    } else {
      running(next, action);
      repository.getMovieModel(action.id).then((item) {
        next(SyncMovieModelAction(moviemodel: item));
        completed(next, action);
      }).catchError((error) {
        catchError(next, action, error);
      });
    }
  };
}

Middleware<AppState> _createGetMovieModels(
    MovieModelRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    if (action.isRefresh) {
      store.state.moviemodelState.page.currPage = 1;
      store.state.moviemodelState.moviemodels.clear();
    } else {
      var p = ++store.state.moviemodelState.page.currPage;
      if (p > ++store.state.moviemodelState.page.totalPage) {
        noMoreItem(next, action);
        return;
      }
    }
    repository
        .getMovieModelsList(store.state.moviemodelState.page.currPage)
        .then((map) {
      if (map.isNotEmpty) {
        print("data deliver");
        var page = Page(
            currPage: map["page"],
            totalPage: map["total_pages"],
            totalCount: map["total_results"]);
        print(page.currPage.toString());

        List l = map["results"] ?? List();
        print(l.length);
       // var map1=Map.fromIterable(l,key: (v)=>v[0],value:(v)=> v[1]);
        List<MovieModel> list = l.map<MovieModel>((item) => new MovieModel.fromJson(item)).toList();

        //print(list.length);
        next(SyncMovieModelsAction(page: page, moviemodels: list));
      }
      completed(next, action);
    }).catchError((error) {
      print(error);
      catchError(next, action, error);
    });
  };
}


Middleware<AppState> _createCreateMovieModel(
    MovieModelRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.createMovieModel(action.moviemodel).then((item) {
      next(SyncMovieModelAction(moviemodel: item));
      completed(next, action);
    }).catchError((error) {
      catchError(next, action, error);
    });
  };
}

Middleware<AppState> _createUpdateMovieModel(
    MovieModelRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.updateMovieModel(action.moviemodel).then((item) {
      next(SyncMovieModelAction(moviemodel: item));
      completed(next, action);
    }).catchError((error) {
      catchError(next, action, error);
    });
  };
}

Middleware<AppState> _createDeleteMovieModel(
    MovieModelRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {
    running(next, action);
    repository.deleteMovieModel(action.moviemodel.id).then((item) {
      next(RemoveMovieModelAction(id: action.moviemodel.id));
      completed(next, action);
    }).catchError((error) {
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
