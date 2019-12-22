import 'package:meta/meta.dart';
import 'package:movie_app/data/model/page_data.dart';
import 'package:movie_app/redux/moviemodel/moviemodel_state.dart';
import 'package:movie_app/redux/nowplaying/nowplaying_state.dart';
import 'package:movie_app/redux/topRated/topRated_state.dart';
import 'package:movie_app/redux/upComing/upComing_state.dart';

/// manage all state of this project
/// auto add new state when using haystack plugin
/// configure the initialize of state
class AppState {
  final MovieModelState moviemodelState;
  final NowPlayingState nowPlayingState;
  final TopRatedState topRatedState;
  final UpComingState upComingState;

  AppState({
    @required this.moviemodelState,
    @required this.nowPlayingState,
    @required this.topRatedState,
    @required this.upComingState,
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
      topRatedState: TopRatedState(
        topRateds: Map(),
        topRated: null,
        status: Map(),
        page: Page(),
      ),
      upComingState: UpComingState(
        upComing: null,
        upComings: Map(),
        status: Map(),
        page: Page(),
      ),
    );
  }
}
