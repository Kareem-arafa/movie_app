import 'package:redux/redux.dart';
import 'package:movie_app/redux/nowplaying/nowplaying_actions.dart';
import 'package:movie_app/redux/nowplaying/nowplaying_state.dart';

final nowplayingReducer = combineReducers<NowPlayingState>([
  TypedReducer<NowPlayingState, NowPlayingStatusAction>(_nowplayingStatus),
  TypedReducer<NowPlayingState, SyncNowPlayingsAction>(_syncNowPlayings),
  TypedReducer<NowPlayingState, SyncNowPlayingAction>(_syncNowPlaying),
  TypedReducer<NowPlayingState, RemoveNowPlayingAction>(_removeNowPlaying),
]);

NowPlayingState _nowplayingStatus(NowPlayingState state, NowPlayingStatusAction action) {
  var status = state.status ?? Map();
  status.update(action.report.actionName, (v) => action.report,
      ifAbsent: () => action.report);
  return state.copyWith(status: status);
}

NowPlayingState _syncNowPlayings(NowPlayingState state, SyncNowPlayingsAction action) {
  for (var nowplaying in action.nowplayings) {
    state.nowplayings.update(nowplaying.id.toString(), (v) => nowplaying, ifAbsent: () => nowplaying);
  }
  state.page.currPage = action.page.currPage;
  state.page.pageSize = action.page.pageSize;
  state.page.totalCount = action.page.totalCount;
  state.page.totalPage = action.page.totalPage;
  return state.copyWith(nowplayings: state.nowplayings);
}

NowPlayingState _syncNowPlaying(NowPlayingState state, SyncNowPlayingAction action) {
  state.nowplayings.update(action.nowplaying.id.toString(), (u) => action.nowplaying,
      ifAbsent: () => action.nowplaying);
  return state.copyWith(nowplayings: state.nowplayings, nowplaying: action.nowplaying);
}

NowPlayingState _removeNowPlaying(NowPlayingState state, RemoveNowPlayingAction action) {
  return state.copyWith(nowplayings: state.nowplayings..remove(action.id.toString()));
}
