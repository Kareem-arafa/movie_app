import 'package:redux/redux.dart';
import 'package:movie_app/data/model/moviemodel_data.dart';
import 'package:movie_app/redux/action_report.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'package:movie_app/redux/moviemodel/moviemodel_actions.dart';

class MovieViewModel {
  final MovieModel moviemodel;
  final List<MovieModel> moviemodels;
  final Function(bool) getMovieModels;
  final Function(bool) getNowPlayingMovieModels;
  final ActionReport getMovieModelsReport;

  MovieViewModel({
    this.moviemodel,
    this.moviemodels,
    this.getMovieModels,
    this.getMovieModelsReport,
    this.getNowPlayingMovieModels
  });

  static MovieViewModel fromStore(Store<AppState> store) {
    return MovieViewModel(
      moviemodel: store.state.moviemodelState.moviemodel,
      moviemodels: store.state.moviemodelState.moviemodels.values.toList() ?? [],
      getMovieModels: (isRefresh) {
        store.dispatch(GetMovieModelsAction(isRefresh: isRefresh));
      },
      getNowPlayingMovieModels: (isRefresh) {
        store.dispatch(GetMovieModelsAction(isRefresh: isRefresh));
      },
      getMovieModelsReport: store.state.moviemodelState.status["GetMovieModelsAction"],

    );
  }
}
