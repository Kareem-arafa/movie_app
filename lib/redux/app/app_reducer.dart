import 'package:movie_app/redux/moviemodel/moviemodel_reducer.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'package:movie_app/redux/MovieDetails/movieDetails_reducer.dart';
import 'package:movie_app/redux/trailer/trailer_reducer.dart';
import 'package:movie_app/redux/cast/cast_reducer.dart';

///register all the Reducer here
///auto add new reducer when using haystack plugin
AppState appReducer(AppState state, dynamic action) {
  return new AppState(
    moviemodelState: moviemodelReducer(state.moviemodelState, action),
    movieDetailsState:movieDetailsReducer(state.movieDetailsState,action),
    trailerState: trailerReducer(state.trailerState,action),
    castState: castReducer(state.castState,action),
  );
}
