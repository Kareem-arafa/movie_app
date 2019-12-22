import 'package:movie_app/redux/moviemodel/moviemodel_reducer.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'package:movie_app/redux/nowplaying/nowplaying_reducer.dart';
import 'package:movie_app/redux/topRated/topRated_reducer.dart';
import 'package:movie_app/redux/upComing/upComing_reducer.dart';

///register all the Reducer here
///auto add new reducer when using haystack plugin
AppState appReducer(AppState state, dynamic action) {
  return new AppState(
    moviemodelState: moviemodelReducer(state.moviemodelState, action),
    nowPlayingState: nowplayingReducer(state.nowPlayingState,action),
    topRatedState: topRatedReducer(state.topRatedState,action),
    upComingState: upComingReducer(state.upComingState,action),
  );
}
