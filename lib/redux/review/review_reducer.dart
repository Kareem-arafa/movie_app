import 'package:redux/redux.dart';
import 'package:movie_app/redux/review/review_action.dart';
import 'package:movie_app/redux/review/review_state.dart';

final reviewReducer = combineReducers<ReviewState>([
  TypedReducer<ReviewState, ReviewStatusAction>(_reviewStatus),
  TypedReducer<ReviewState, SyncReviewAction>(_syncReviews),
]);

ReviewState _reviewStatus(ReviewState state, ReviewStatusAction action) {
  var status = state.status ?? Map();
  status.update(action.report.actionName, (v) => action.report,
      ifAbsent: () => action.report);
  return state.copyWith(status: status);
}
ReviewState _syncReviews(ReviewState state, SyncReviewAction action) {
  state.reviews.update(action.reviewModel.id.toString(), (u) => action.reviewModel,
      ifAbsent: () => action.reviewModel);
  return state.copyWith( reviewModel: action.reviewModel);
}
