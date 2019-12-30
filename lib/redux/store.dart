import 'dart:async';

import 'package:logging/logging.dart';
import 'package:movie_app/redux/app/app_reducer.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'package:movie_app/redux/moviemodel/moviemodel_middleware.dart';
import 'package:movie_app/redux/MovieDetails/movieDetails_middleware.dart';
import 'package:movie_app/redux/trailer/trailer_middleware.dart';
import 'package:movie_app/redux/cast/cast_middleware.dart';
import 'package:movie_app/redux/review/review_middleware.dart';
import 'package:movie_app/redux/favorite/favorite_middleware.dart';

import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';


Future<Store<AppState>> createStore() async {
  return Store(
    appReducer,
    initialState: AppState.initial(),
    middleware: []
      ..addAll(createMovieModelMiddleware())
      ..addAll(createMovieDetailsMiddleware())
      ..addAll(createTrailerMiddleware())
      ..addAll(createCastMiddleware())
      ..addAll(createReviewMiddleware())
      ..addAll(createFavoriteMiddleware())
      ..addAll([
        LoggingMiddleware<dynamic>.printer(level: Level.ALL),
      ]),
  );
}
