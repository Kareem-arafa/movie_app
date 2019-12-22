import 'package:movie_app/redux/action_report.dart';
import 'package:movie_app/redux/app/app_state.dart';
import 'package:movie_app/redux/upComing/upComing_action.dart';
import 'package:redux/redux.dart';
import 'package:movie_app/data/model/upComing_data.dart';


class UpComingViewModel {
  final UpComing upComing;
  final List<UpComing> upComings;
  final Function(bool) getUpComigs;
  final ActionReport getUpComingReport;

  UpComingViewModel({
    this.upComing,
    this.getUpComigs,
    this.getUpComingReport,
    this.upComings,
  });

  static UpComingViewModel fromStore(Store<AppState> store) {
    return UpComingViewModel(
      upComing: store.state.upComingState.upComing,
      upComings: store.state.upComingState.upComings.values.toList() ?? [],
      getUpComigs: (isRefresh) {
        store.dispatch(GetUpComingsAction(isRefresh: isRefresh));
      },
      getUpComingReport: store.state.upComingState.status["GetUpComingsAction"],
    );
  }
}

