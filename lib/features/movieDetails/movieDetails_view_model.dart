import 'package:movie_app/data/model/cast_data.dart';
import 'package:movie_app/data/model/movieDetails_data.dart';
import 'package:movie_app/data/model/trailler_data.dart';
import 'package:movie_app/data/model/reviwews_data.dart';
import 'package:movie_app/redux/MovieDetails/movieDetails_action.dart';
import 'package:movie_app/redux/action_report.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'package:movie_app/redux/cast/cast_action.dart';
import 'package:movie_app/redux/trailer/trailer_action.dart';
import 'package:movie_app/redux/review/review_action.dart';
import 'package:redux/redux.dart';

class MovieDetailsViewModel {
  final DetailsModel detailsModel;
  final TrailerModel trailers;
  final CastModel castModel;
  final ReviewModel reviewModel;

  final Function(int) getMovieDetails;
  final Function(int) getTrailer;
  final Function(int)getCast;
  final Function(int) getReview;

  final ActionReport getMovieDetailsReport;
  final ActionReport getTrailerReport;
  final ActionReport getCastReport;
  final ActionReport getReviewReport;

  MovieDetailsViewModel({
    this.reviewModel,
    this.castModel,
    this.trailers,
    this.getTrailerReport,
    this.detailsModel,
    this.getMovieDetails,
    this.getMovieDetailsReport,
    this.getCastReport,
    this.getReview,
    this.getReviewReport,
    this.getTrailer,
    this.getCast,
  });

  static MovieDetailsViewModel fromStore(Store<AppState> store) {
    return MovieDetailsViewModel(
      detailsModel: store.state.movieDetailsState.detailsModel,
      trailers: store.state.trailerState.trailerModel,
      castModel: store.state.castState.castModel,
      reviewModel: store.state.reviewState.reviewModel,
      getMovieDetails: (id) {
        print("View model id :$id");
        store.dispatch(GetMovieDetailsAction(id: id));
      },
      getTrailer: (id) {
        store.dispatch(GetTrailersAction(id:id));
      },
      getCast: (id){
        store.dispatch(GetCastAction(id: id));
      },
      getReview: (id){
        store.dispatch(GetReviewAction(id: id));
      },
      getMovieDetailsReport:
          store.state.movieDetailsState.status["GetMovieDetailsAction"],
      getTrailerReport:
      store.state.trailerState.status["GetTrailersAction"],
      getCastReport: store.state.castState.status['GetCastAction'],
      getReviewReport: store.state.reviewState.status['GetReviewAction'],

    );
  }
}
