import 'package:flutter/material.dart';
import 'package:movie_app/data/model/topRated_data.dart';
import 'package:movie_app/data/model/page_data.dart';

import '../action_report.dart';

class GetTopRatedsAction {
  final String actionName = "GetTopRatedsAction";
  final bool isRefresh;

  GetTopRatedsAction({this.isRefresh});
}

class TopRatedStatusAction {
  final String actionName = "TopRatedStatusAction";
  final ActionReport report;

  TopRatedStatusAction({@required this.report});
}

class SyncTopRatedsAction {
  final String actionName = "SyncTopRatedsAction";
  final Page page;
  final List<TopRated> topRateds;

  SyncTopRatedsAction({this.page, this.topRateds});
}

