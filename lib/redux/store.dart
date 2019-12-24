import 'package:logging/logging.dart';
import 'package:movie_app/redux/app/app_reducer.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'package:movie_app/redux/moviemodel/moviemodel_middleware.dart';
import 'package:movie_app/redux/nowplaying/nowplaying_middleware.dart';
import 'package:movie_app/redux/topRated/topRated_middleware.dart';
import 'package:movie_app/redux/upComing/upComing_middleware.dart';
import 'package:movie_app/redux/MovieDetails/movieDetails_middleware.dart';
import 'package:movie_app/redux/trailer/trailer_middleware.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';


Future<Store<AppState>> createStore() async {
  return Store(
    appReducer,
    initialState: AppState.initial(),
    middleware: []
      ..addAll(createNowPlayingMiddleware())
      ..addAll(createMovieModelMiddleware())
      ..addAll(createTopRatedMiddleware())
      ..addAll(createUpComingMiddleware())
      ..addAll(createMovieDetailsMiddleware())
      ..addAll(createTrailerMiddleware())
      ..addAll([
        LoggingMiddleware<dynamic>.printer(level: Level.ALL),
      ]),
  );
}
