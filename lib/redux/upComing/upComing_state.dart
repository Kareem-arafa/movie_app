import 'package:meta/meta.dart';
import 'package:movie_app/data/model/upComing_data.dart';
import 'package:movie_app/data/model/page_data.dart';
import 'package:movie_app/redux/action_report.dart';

class UpComingState {
  final Map<String, UpComing> upComings;
  final UpComing upComing;
  final Map<String, ActionReport> status;
  final Page page;

  UpComingState({
    @required this.upComing,
    @required this.upComings,
    @required this.status,
    @required this.page,
  });

  UpComingState copyWith({
    Map<String, UpComing> upComings,
    UpComing upComing,
    Map<String, ActionReport> status,
    Page page,
  }) {
    return UpComingState(
      upComings: upComings ?? this.upComings ?? Map(),
      upComing: upComing ?? this.upComing,
      status: status ?? this.status,
      page: page ?? this.page,
    );
  }
}
