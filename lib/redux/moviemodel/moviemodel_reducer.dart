import 'package:movie_app/redux/moviemodel/moviemodel_actions.dart';
import 'package:movie_app/redux/moviemodel/moviemodel_state.dart';
import 'package:redux/redux.dart';

final moviemodelReducer = combineReducers<MovieModelState>([
  TypedReducer<MovieModelState, MovieModelStatusAction>(_moviemodelStatus),
  TypedReducer<MovieModelState, SyncMovieModelsAction>(_syncMovieModels),
]);

MovieModelState _moviemodelStatus(
    MovieModelState state, MovieModelStatusAction action) {
  var status = state.status ?? Map();
  status.update(action.report.actionName, (v) => action.report,
      ifAbsent: () => action.report);
  return state.copyWith(status: status);
}

MovieModelState _syncMovieModels(
    MovieModelState state, SyncMovieModelsAction action) {
  state.moviemodels.putIfAbsent(action.type, () => Map());
  for (var moviemodel in action.moviemodels) {
    state.moviemodels[action.type].update(
        moviemodel.id.toString(), (v) => moviemodel,
        ifAbsent: () => moviemodel);
  }
  state.page.currPage = action.page.currPage;
  state.page.pageSize = action.page.pageSize;
  state.page.totalCount = action.page.totalCount;
  state.page.totalPage = action.page.totalPage;
  return state.copyWith(moviemodels: state.moviemodels);
}
