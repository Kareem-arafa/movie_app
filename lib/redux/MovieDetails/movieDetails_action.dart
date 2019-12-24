import 'package:flutter/material.dart';
import 'package:movie_app/data/model/movieDetails_data.dart';

import '../action_report.dart';

class GetMovieDetailsAction {
  final String actionName = "GetMovieDetailsAction";
  final int id;

  GetMovieDetailsAction({this.id});
}

class MovieDetailsStatusAction {
  final String actionName = "MovieDetailsStatusAction";
  final ActionReport report;

  MovieDetailsStatusAction({@required this.report});
}

class SyncMovieDetailsAction {
  final String actionName = "SyncMovieDetailsAction";
  final DetailsModel detailsModel;

  SyncMovieDetailsAction({this.detailsModel});
}

