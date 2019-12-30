import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:movie_app/data/model/movieDetails_data.dart';
import 'package:movie_app/redux/action_report.dart';

class FavoriteState {
   Box<dynamic> favorite;
  final Map<String, ActionReport> status;


  FavoriteState({
    @required this.favorite,
    @required this.status,
  });

  FavoriteState copyWith({
    final Box<dynamic> favorite,
    Map<String, ActionReport> status,
  }) {
    return FavoriteState(
      favorite: favorite ?? this.favorite ,
      status: status ?? this.status,
    );
  }
}
