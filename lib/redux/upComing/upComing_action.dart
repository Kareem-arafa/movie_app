import 'package:flutter/material.dart';
import 'package:movie_app/data/model/upComing_data.dart';
import 'package:movie_app/data/model/page_data.dart';

import '../action_report.dart';

class GetUpComingsAction {
  final String actionName = "GetUpComingsAction";
  final bool isRefresh;

  GetUpComingsAction({this.isRefresh});
}

class UpComingStatusAction {
  final String actionName = "UpComingStatusAction";
  final ActionReport report;

  UpComingStatusAction({@required this.report});
}

class SyncUpComingsAction {
  final String actionName = "SyncUpComingsAction";
  final Page page;
  final List<UpComing> upComings;

  SyncUpComingsAction({this.page, this.upComings});
}

