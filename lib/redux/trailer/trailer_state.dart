import 'package:meta/meta.dart';
import 'package:movie_app/data/model/trailler_data.dart';
import 'package:movie_app/redux/action_report.dart';

class TrailerState {
  final TrailerModel trailerModel;
  final Map<String,TrailerModel> trailers;
  final Map<String, ActionReport> status;

  TrailerState({
    @required this.trailers,
    @required this.trailerModel,
    @required this.status,
  });

  TrailerState copyWith({
    TrailerModel trailerModel,
    final Map<String,TrailerModel> trailers,
    Map<String, ActionReport> status,
  }) {
    return TrailerState(
      trailerModel: trailerModel ?? this.trailerModel,
      status: status ?? this.status,
      trailers: trailers?? this.trailers,
    );
  }
}
