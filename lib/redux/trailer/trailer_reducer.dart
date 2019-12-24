import 'package:redux/redux.dart';
import 'package:movie_app/redux/trailer/trailer_action.dart';
import 'package:movie_app/redux/trailer/trailer_state.dart';

final trailerReducer = combineReducers<TrailerState>([
  TypedReducer<TrailerState, TrailerStatusAction>(_trailersStatus),
  TypedReducer<TrailerState, SyncTrailersAction>(_syncTrailers),
]);

TrailerState _trailersStatus(TrailerState state, TrailerStatusAction action) {
  var status = state.status ?? Map();
  status.update(action.report.actionName, (v) => action.report,
      ifAbsent: () => action.report);
  return state.copyWith(status: status);
}
/*TrailerState _syncTrailers(TrailerState state, SyncTrailersAction action) {
  state.trailers.update(action.trailer.id.toString(), (u) => action.detailsModel,
      ifAbsent: () => action.detailsModel);
  return state.copyWith(detailsModels: state.detailsModels, detailsModel: action.detailsModel);
  // last
   for (var trailer in action.trailer) {
    state.trailers.update(trailer.id.toString(), (v) => trailer, ifAbsent: () => trailer);
  }
  return state.copyWith(trailers: state.trailers);
}*/
TrailerState _syncTrailers(TrailerState state, SyncTrailersAction action) {
  state.trailers.update(action.trailer.id.toString(), (u) => action.trailer,
      ifAbsent: () => action.trailer);
  return state.copyWith( trailerModel: action.trailer);
}
