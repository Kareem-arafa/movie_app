import 'package:meta/meta.dart';
import 'package:movie_app/data/model/trailler_data.dart';
import 'package:movie_app/redux/action_report.dart';

class GetTrailersAction {
  final String actionName = "GetTrailersAction";
  final int id;

  GetTrailersAction({this.id});
}

class TrailerStatusAction {
  final String actionName = "TrailerStatusAction";
  final ActionReport report;

  TrailerStatusAction({@required this.report});
}

class SyncTrailersAction {
  final String actionName = "SyncTrailersAction";
  final TrailerModel trailer;

  SyncTrailersAction({ this.trailer});
}


