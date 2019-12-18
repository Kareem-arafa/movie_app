import 'package:redux/redux.dart';
import 'package:movie_app/redux/moviemodel/moviemodel_actions.dart';
import 'package:movie_app/redux/moviemodel/moviemodel_state.dart';

final moviemodelReducer = combineReducers<MovieModelState>([
  TypedReducer<MovieModelState, MovieModelStatusAction>(_moviemodelStatus),
  TypedReducer<MovieModelState, SyncMovieModelsAction>(_syncMovieModels),
  TypedReducer<MovieModelState, SyncMovieModelAction>(_syncMovieModel),
  TypedReducer<MovieModelState, RemoveMovieModelAction>(_removeMovieModel),
]);

MovieModelState _moviemodelStatus(MovieModelState state, MovieModelStatusAction action) {
  var status = state.status ?? Map();
  status.update(action.report.actionName, (v) => action.report,
      ifAbsent: () => action.report);
  return state.copyWith(status: status);
}

MovieModelState _syncMovieModels(MovieModelState state, SyncMovieModelsAction action) {
  for (var moviemodel in action.moviemodels) {
    state.moviemodels.update(moviemodel.id.toString(), (v) => moviemodel, ifAbsent: () => moviemodel);
  }
  state.page.currPage = action.page.currPage;
  state.page.pageSize = action.page.pageSize;
  state.page.totalCount = action.page.totalCount;
  state.page.totalPage = action.page.totalPage;
  return state.copyWith(moviemodels: state.moviemodels);
}

MovieModelState _syncMovieModel(MovieModelState state, SyncMovieModelAction action) {
  state.moviemodels.update(action.moviemodel.id.toString(), (u) => action.moviemodel,
      ifAbsent: () => action.moviemodel);
  return state.copyWith(moviemodels: state.moviemodels, moviemodel: action.moviemodel);
}

MovieModelState _removeMovieModel(MovieModelState state, RemoveMovieModelAction action) {
  return state.copyWith(moviemodels: state.moviemodels..remove(action.id.toString()));
}
