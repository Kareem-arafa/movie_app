import 'package:meta/meta.dart';
import 'package:movie_app/data/model/reviwews_data.dart';
import 'package:movie_app/redux/action_report.dart';

class GetReviewAction {
  final String actionName = "GetReviewAction";
  final int id;

  GetReviewAction({this.id});
}

class ReviewStatusAction {
  final String actionName = "ReviewStatusAction";
  final ActionReport report;

  ReviewStatusAction({@required this.report});
}

class SyncReviewAction {
  final String actionName = "SyncTrailersAction";
  final ReviewModel reviewModel;

  SyncReviewAction({ this.reviewModel});
}


