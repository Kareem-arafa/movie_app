import 'package:redux/redux.dart';
import 'package:movie_app/redux/action_report.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'package:movie_app/redux/review/review_action.dart';
import 'package:movie_app/data/remote/review_repository.dart';

List<Middleware<AppState>> createReviewMiddleware([
  ReviewsRepository _repository = const ReviewsRepository(),
]) {

  final getReview = _createGetReview(_repository);

  return [
    TypedMiddleware<AppState, GetReviewAction>(getReview),
  ];
}

Middleware<AppState> _createGetReview(
    ReviewsRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) {

    running(next, action);
    repository
        .getReviews(action.id)
        .then((data) {
          print('.........middleware..........${data.toString()}');
        next(SyncReviewAction(reviewModel: data));
      completed(next, action);
    }).catchError((error) {
      print(error);
      catchError(next, action, error);
    });
  };
}


void catchError(NextDispatcher next, action, error) {
  next(ReviewStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.error,
          msg: "${action.actionName} is error;${error.toString()}")));
}

void completed(NextDispatcher next, action) {
  next(ReviewStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.complete,
          msg: "${action.actionName} is completed")));
}

void noMoreItem(NextDispatcher next, action) {
  next(ReviewStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.complete,
          msg: "no more items")));
}

void running(NextDispatcher next, action) {
  next(ReviewStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.running,
          msg: "${action.actionName} is running")));
}

void idEmpty(NextDispatcher next, action) {
  next(ReviewStatusAction(
      report: ActionReport(
          actionName: action.actionName,
          status: ActionStatus.error,
          msg: "Id is empty")));
}
