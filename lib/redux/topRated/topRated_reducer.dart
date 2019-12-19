import 'package:redux/redux.dart';
import 'package:movie_app/redux/topRated/topRated_action.dart';
import 'package:movie_app/redux/topRated/topRated_state.dart';

final topRatedReducer = combineReducers<TopRatedState>([
  TypedReducer<TopRatedState, TopRatedStatusAction>(_topRatedStatus),
  TypedReducer<TopRatedState, SyncTopRatedsAction>(_syncTopRateds),
]);

TopRatedState _topRatedStatus(TopRatedState state, TopRatedStatusAction action) {
  var status = state.status ?? Map();
  status.update(action.report.actionName, (v) => action.report,
      ifAbsent: () => action.report);
  return state.copyWith(status: status);
}

TopRatedState _syncTopRateds(TopRatedState state, SyncTopRatedsAction action) {
  for (var topRated in action.topRateds) {
    state.topRateds.update(topRated.id.toString(), (v) => topRated, ifAbsent: () => topRated);
  }
  state.page.currPage = action.page.currPage;
  state.page.pageSize = action.page.pageSize;
  state.page.totalCount = action.page.totalCount;
  state.page.totalPage = action.page.totalPage;
  return state.copyWith(topRateds: state.topRateds);
}

