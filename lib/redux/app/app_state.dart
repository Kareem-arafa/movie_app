import 'package:movie_app/redux/moviemodel/moviemodel_state.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/data/model/page_data.dart';

/// manage all state of this project
/// auto add new state when using haystack plugin
/// configure the initialize of state
class AppState {
  final MovieModelState moviemodelState;

  AppState({
    @required this.moviemodelState,

  });

  factory AppState.initial() {
    return AppState(
        moviemodelState: MovieModelState(
            moviemodel: null,
            moviemodels: Map(),
            status: Map(),
            page: Page(),),

    );
  }
}
