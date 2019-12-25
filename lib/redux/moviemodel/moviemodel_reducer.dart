import 'package:movie_app/data/model/page_data.dart';
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
  state.page.putIfAbsent(action.type, () => Page());
  for (var moviemodel in action.moviemodels) {
    state.moviemodels[action.type].update(
        moviemodel.id.toString(), (v) => moviemodel,
        ifAbsent: () => moviemodel);
  }
  state.page[action.type].currPage = action.page[action.type].currPage;
  state.page[action.type].pageSize = action.page[action.type].pageSize;
  state.page[action.type].totalCount = action.page[action.type].totalCount;
  state.page[action.type].totalPage = action.page[action.type].totalPage;
  return state.copyWith(moviemodels: state.moviemodels);
}
