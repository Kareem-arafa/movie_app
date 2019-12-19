import 'package:meta/meta.dart';
import 'package:movie_app/data/model/page_data.dart';
import 'package:movie_app/redux/moviemodel/moviemodel_state.dart';
import 'package:movie_app/redux/nowplaying/nowplaying_state.dart';

/// manage all state of this project
/// auto add new state when using haystack plugin
/// configure the initialize of state
class AppState {
  final MovieModelState moviemodelState;
  final NowPlayingState nowPlayingState;

  AppState({
    @required this.moviemodelState,
    @required this.nowPlayingState,
  });

  factory AppState.initial() {
    return AppState(
      moviemodelState: MovieModelState(
        moviemodel: null,
        moviemodels: Map(),
        status: Map(),
        page: Page(),
      ),
      nowPlayingState: NowPlayingState(
        page: Page(),
        nowplayings: Map(),
        nowplaying: null,
        status: Map(),
      ),
    );
  }
}
