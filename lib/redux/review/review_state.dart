import 'package:meta/meta.dart';
import 'package:movie_app/data/model/reviwews_data.dart';
import 'package:movie_app/redux/action_report.dart';

class ReviewState {
  final ReviewModel reviewModel;
  final Map<String,ReviewModel> reviews;
  final Map<String, ActionReport> status;

  ReviewState({
    @required this.reviewModel,
    @required this.reviews,
    @required this.status,
  });

  ReviewState copyWith({
    ReviewModel reviewModel,
    final Map<String,ReviewModel> reviews,
    Map<String, ActionReport> status,
  }) {
    return ReviewState(
      reviewModel: reviewModel ?? this.reviewModel,
      status: status ?? this.status,
      reviews: reviews?? this.reviews,
    );
  }
}
