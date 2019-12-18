import 'package:movie_app/redux/moviemodel/moviemodel_reducer.dart';
import 'package:movie_app/redux/app/app_state.dart';

///register all the Reducer here
///auto add new reducer when using haystack plugin
AppState appReducer(AppState state, dynamic action) {
  return new AppState(
    moviemodelState: moviemodelReducer(state.moviemodelState, action),

  );
}
