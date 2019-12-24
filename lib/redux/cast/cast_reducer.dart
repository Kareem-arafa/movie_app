import 'package:redux/redux.dart';
import 'package:movie_app/redux/cast/cast_action.dart';
import 'package:movie_app/redux/cast/cast_state.dart';

final castReducer = combineReducers<CastState>([
  TypedReducer<CastState, CastStatusAction>(_castStatus),
  TypedReducer<CastState, SyncCastAction>(_syncCast),
]);

CastState _castStatus(CastState state, CastStatusAction action) {
  var status = state.status ?? Map();
  status.update(action.report.actionName, (v) => action.report,
      ifAbsent: () => action.report);
  return state.copyWith(status: status);
}

CastState _syncCast(CastState state, SyncCastAction action) {
  state.casts.update(action.castModel.id.toString(), (u) => action.castModel,
      ifAbsent: () => action.castModel);
  return state.copyWith( castModel: action.castModel);
}
