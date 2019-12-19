import 'package:redux/redux.dart';
import 'package:movie_app/data/model/nowplaying_data.dart';
import 'package:movie_app/redux/action_report.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'package:movie_app/redux/nowplaying/nowplaying_actions.dart';

class nowplayinViewModel {
  final NowPlaying nowplaying;
  final List<NowPlaying> nowplayings;
  final Function(bool) getNowPlayings;
  final ActionReport getNowPlayingsReport;

  nowplayinViewModel({
    this.nowplaying,
    this.nowplayings,
    this.getNowPlayings,
    this.getNowPlayingsReport,
  });

  static nowplayinViewModel fromStore(Store<AppState> store) {
    return nowplayinViewModel(
      nowplaying: store.state.nowPlayingState.nowplaying,
      nowplayings: store.state.nowPlayingState.nowplayings.values.toList() ?? [],
      getNowPlayings: (isRefresh) {
        store.dispatch(GetNowPlayingsAction(isRefresh: isRefresh));
      },
      getNowPlayingsReport: store.state.nowPlayingState.status["GetNowPlayingsAction"],
    );
  }
}
