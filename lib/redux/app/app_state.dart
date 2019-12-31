import 'package:meta/meta.dart';
import 'package:movie_app/redux/MovieDetails/movieDetails_state.dart';
import 'package:movie_app/redux/cast/cast_state.dart';
import 'package:movie_app/redux/favorite/favorite_state.dart';
import 'package:movie_app/redux/moviemodel/moviemodel_state.dart';
import 'package:movie_app/redux/review/review_state.dart';
import 'package:movie_app/redux/trailer/trailer_state.dart';

/// manage all state of this project
/// auto add new state when using haystack plugin
/// configure the initialize of state
class AppState {
  final MovieModelState moviemodelState;
  final ReviewState reviewState;
  final MovieDetailsState movieDetailsState;
  final TrailerState trailerState;
  final CastState castState;
  final FavoriteState favoriteState;

  AppState({
    @required this.reviewState,
    @required this.castState,
    @required this.trailerState,
    @required this.moviemodelState,
    @required this.movieDetailsState,
    @required this.favoriteState,
  });
    factory AppState.isLoading(){

    return AppState.isLoading();
  }

  factory AppState.initial() {
    return AppState(
      moviemodelState: MovieModelState(
        loading: true,
        moviemodel: null,
        moviemodels: Map(),
        status: Map(),
        page: Map(),
      ),
      movieDetailsState: MovieDetailsState(
        status: Map(),
        detailsModel: null,
        detailsModels: Map(),
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
      reviewState: ReviewState(
        reviewModel: null,
        status: Map(),
        reviews: Map(),
      ),
      favoriteState: FavoriteState(
        status: Map(),
        favorite: null,
      ),
    );
  }
}
