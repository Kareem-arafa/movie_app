import 'package:meta/meta.dart';
import 'package:movie_app/data/model/cast_data.dart';
import 'package:movie_app/data/model/trailler_data.dart';
import 'package:movie_app/redux/action_report.dart';

class GetCastAction {
  final String actionName = "GetCastAction";
  final int id;

  GetCastAction({this.id});
}

class CastStatusAction {
  final String actionName = "CastStatusAction";
  final ActionReport report;

  CastStatusAction({@required this.report});
}

class SyncCastAction {
  final String actionName = "SyncCastAction";
  final CastModel castModel;

  SyncCastAction({ this.castModel});
}


