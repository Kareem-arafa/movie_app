import 'package:redux/redux.dart';
import 'package:movie_app/redux/MovieDetails/movieDetails_action.dart';
import 'package:movie_app/redux/MovieDetails/movieDetails_state.dart';

final movieDetailsReducer = combineReducers<MovieDetailsState>([
  TypedReducer<MovieDetailsState, MovieDetailsStatusAction>(_movieDetailsStatus),
  TypedReducer<MovieDetailsState, SyncMovieDetailsAction>(_syncMovieDetails),
]);

MovieDetailsState _movieDetailsStatus(MovieDetailsState state, MovieDetailsStatusAction action) {
  var status = state.status ?? Map();
  status.update(action.report.actionName, (v) => action.report,
      ifAbsent: () => action.report);
  return state.copyWith(status: status);
}

MovieDetailsState _syncMovieDetails(MovieDetailsState state, SyncMovieDetailsAction action) {
  state.detailsModels.update(action.detailsModel.id.toString(), (u) => action.detailsModel,
      ifAbsent: () => action.detailsModel);
  return state.copyWith(detailsModels: state.detailsModels, detailsModel: action.detailsModel);
}
