import 'package:enum_to_string/enum_to_string.dart';
import 'package:redux/redux.dart';
import 'package:movie_app/data/model/moviemodel_data.dart';
import 'package:movie_app/redux/action_report.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'package:movie_app/redux/moviemodel/moviemodel_actions.dart';
import 'package:movie_app/redux/moviemodel/moviemodel_state.dart';

class MovieViewModel {
  final MovieModelState movieModelState;
  final MovieModel moviemodel;
  final List<MovieModel> moviemodels;
  final Function(bool) getMovieModels;
  final Function(bool) getNowPlayingMovieModels;
  final ActionReport getMovieModelsReport;

  MovieViewModel({
    this.movieModelState,
    this.moviemodel,
    this.moviemodels,
    this.getMovieModels,
    this.getMovieModelsReport,
    this.getNowPlayingMovieModels
  });

  static MovieViewModel fromStore(Store<AppState> store, String type) {
    return MovieViewModel(
      movieModelState: store.state.moviemodelState,
      moviemodel: store.state.moviemodelState.moviemodel,
      moviemodels: store.state.moviemodelState?.moviemodels[type]?.values?.toList() ?? [],
      getMovieModels: (isRefresh) {
        store.dispatch(GetMovieModelsAction(isRefresh: isRefresh,type: type));
      },
      getMovieModelsReport: store.state.moviemodelState.status["GetMovieModelsAction"],

    );
  }
}
