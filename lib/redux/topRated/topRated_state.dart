import 'package:meta/meta.dart';
import 'package:movie_app/data/model/topRated_data.dart';
import 'package:movie_app/data/model/page_data.dart';
import 'package:movie_app/redux/action_report.dart';

class TopRatedState {
  final Map<String, TopRated> topRateds;
  final TopRated topRated;
  final Map<String, ActionReport> status;
  final Page page;

  TopRatedState({
    @required this.topRateds,
    @required this.topRated,
    @required this.status,
    @required this.page,
  });

  TopRatedState copyWith({
    Map<String, TopRated> topRateds,
    TopRated topRated,
    Map<String, ActionReport> status,
    Page page,
  }) {
    return TopRatedState(
      topRateds: topRateds ?? this.topRateds ?? Map(),
      topRated: topRated ?? this.topRated,
      status: status ?? this.status,
      page: page ?? this.page,
    );
  }
}
