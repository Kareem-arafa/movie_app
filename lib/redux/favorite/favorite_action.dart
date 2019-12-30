import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/data/model/movieDetails_data.dart';
import 'package:movie_app/redux/action_report.dart';

class GetFavoriteAction {
  final String actionName = "GetFavoriteAction";
}

class GetAddFavoriteAction {
  final String actionName = "GetAddFavoriteAction";
  final DetailsModel detailsModel;

  GetAddFavoriteAction({this.detailsModel});
}

class GetRemoveFavoriteAction {
  final String actionName = "GetRemoveFavoriteAction";
  final int index;
  GetRemoveFavoriteAction({this.index});
}

class FavoriteStatusAction {
  final String actionName = "FavoriteStatusAction";
  final ActionReport report;

  FavoriteStatusAction({@required this.report});
}

class SyncFavoriteAction {
  final String actionName = "SyncFavoriteAction";
  final Box<dynamic> favorites;

  SyncFavoriteAction({this.favorites});
}





