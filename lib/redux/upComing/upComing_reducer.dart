import 'package:redux/redux.dart';
import 'package:movie_app/redux/upComing/upComing_action.dart';
import 'package:movie_app/redux/upComing/upComing_state.dart';

final upComingReducer = combineReducers<UpComingState>([
  TypedReducer<UpComingState, UpComingStatusAction>(_upComingStatus),
  TypedReducer<UpComingState, SyncUpComingsAction>(_syncUpComing),
]);

UpComingState _upComingStatus(UpComingState state, UpComingStatusAction action) {
  var status = state.status ?? Map();
  status.update(action.report.actionName, (v) => action.report,
      ifAbsent: () => action.report);
  return state.copyWith(status: status);
}

UpComingState _syncUpComing(UpComingState state, SyncUpComingsAction action) {
  for (var upComing in action.upComings) {
    state.upComings.update(upComing.id.toString(), (v) => upComing, ifAbsent: () => upComing);
  }
  state.page.currPage = action.page.currPage;
  state.page.pageSize = action.page.pageSize;
  state.page.totalCount = action.page.totalCount;
  state.page.totalPage = action.page.totalPage;
  return state.copyWith(upComings: state.upComings);
}

