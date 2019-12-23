import 'package:movie_app/redux/MovieDetails/movieDetails_action.dart';
import 'package:redux/redux.dart';
import 'package:movie_app/data/model/movieDetails_data.dart';
import 'package:movie_app/redux/action_report.dart';
import 'package:movie_app/redux/app/app_state.dart';

class MovieDetailsViewModel {
  final DetailsModel detailsModel;
  final Function(int) getMovieDetails;
  final ActionReport getMovieDetailsReport;

  MovieDetailsViewModel({
    this.detailsModel,
    this.getMovieDetails,
    this.getMovieDetailsReport,
  });

  static MovieDetailsViewModel fromStore(Store<AppState> store) {
    return MovieDetailsViewModel(
      detailsModel: store.state.movieDetailsState.detailsModel,
      getMovieDetails: (id) {
        print("View model id :$id");
        store.dispatch(GetMovieDetailsAction(id: id));
      },
      getMovieDetailsReport: store.state.movieDetailsState.status["GetMovieDetailsAction"],

    );
  }
}
