import 'package:movie_app/data/model/movieDetails_data.dart';
import 'package:movie_app/data/model/trailler_data.dart';
import 'package:movie_app/redux/MovieDetails/movieDetails_action.dart';
import 'package:movie_app/redux/action_report.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'package:movie_app/redux/trailer/trailer_action.dart';
import 'package:redux/redux.dart';

class MovieDetailsViewModel {
  final DetailsModel detailsModel;
  final TrailerModel trailers;
  final Function(int) getMovieDetails;
  final Function(int) getTrailer;
  final ActionReport getMovieDetailsReport;
  final ActionReport getTrailerReport;

  MovieDetailsViewModel({
    this.trailers,
    this.getTrailerReport,
    this.detailsModel,
    this.getMovieDetails,
    this.getMovieDetailsReport,
    this.getTrailer,
  });

  static MovieDetailsViewModel fromStore(Store<AppState> store) {
    return MovieDetailsViewModel(
      detailsModel: store.state.movieDetailsState.detailsModel,
      trailers: store.state.trailerState.trailerModel,
      getMovieDetails: (id) {
        print("View model id :$id");
        store.dispatch(GetMovieDetailsAction(id: id));
      },
      getTrailer: (id) {
        store.dispatch(GetTrailersAction(id:id));
      },
      getMovieDetailsReport:
          store.state.movieDetailsState.status["GetMovieDetailsAction"],
      getTrailerReport:
      store.state.trailerState.status["GetTrailersAction"],
    );
  }
}
