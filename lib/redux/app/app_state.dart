import 'package:meta/meta.dart';
import 'package:movie_app/data/model/page_data.dart';
import 'package:movie_app/redux/MovieDetails/movieDetails_state.dart';
import 'package:movie_app/redux/cast/cast_state.dart';
import 'package:movie_app/redux/moviemodel/moviemodel_state.dart';
import 'package:movie_app/redux/trailer/trailer_state.dart';

/// manage all state of this project
/// auto add new state when using haystack plugin
/// configure the initialize of state
class AppState {
  final MovieModelState moviemodelState;

  final MovieDetailsState movieDetailsState;
  final TrailerState trailerState;
  final CastState castState;

  AppState({
    @required this.castState,
    @required this.trailerState,
    @required this.moviemodelState,
    @required this.movieDetailsState,
  });

  factory AppState.initial() {
    return AppState(
      moviemodelState: MovieModelState(
        moviemodel: null,
        moviemodels: Map(),
        status: Map(),
        page: Page(),
      ),
      movieDetailsState: MovieDetailsState(
        status: Map(),
        detailsModel: null,
        detailsModels: Map(),
        page: Page(),
      ),
      trailerState: TrailerState(
        trailers: Map(),
        trailerModel: null,
        status: Map(),
      ),
      castState: CastState(
        casts: Map(),
        castModel: null,
        status: Map(),
      ),
    );
  }
}
