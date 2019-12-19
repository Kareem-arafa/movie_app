
import 'package:movie_app/redux/action_report.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'package:movie_app/redux/topRated/topRated_action.dart';
import 'package:redux/redux.dart';
import 'package:movie_app/data/model/topRated_data.dart';


class TopRatedViewModel {
  final TopRated topRated;
  final List<TopRated> topRateds;
  final Function(bool) getTopRateds;
  final ActionReport getTopRatedReport;

  TopRatedViewModel({
    this.topRated,
    this.getTopRateds,
    this.getTopRatedReport,
    this.topRateds,
  });

  static TopRatedViewModel fromStore(Store<AppState> store) {
    return TopRatedViewModel(
      topRated: store.state.topRatedState.topRated,
      topRateds: store.state.topRatedState.topRateds.values.toList() ?? [],
      getTopRateds: (isRefresh) {
        store.dispatch(GetTopRatedsAction(isRefresh: isRefresh));
      },
      getTopRatedReport: store.state.topRatedState.status["GetTopRatedsAction"],
    );
  }
}

