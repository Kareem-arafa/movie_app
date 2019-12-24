import 'package:meta/meta.dart';
import 'package:movie_app/data/model/cast_data.dart';
import 'package:movie_app/redux/action_report.dart';

class CastState {
  final CastModel castModel;
  final Map<String,CastModel> casts;
  final Map<String, ActionReport> status;

  CastState({
    @required this.castModel,
    @required this.casts,
    @required this.status,
  });

  CastState copyWith({
    CastModel castModel,
    final Map<String,CastModel> casts,
    Map<String, ActionReport> status,
  }) {
    return CastState(
      castModel: castModel ?? this.castModel,
      status: status ?? this.status,
      casts: casts?? this.casts,
    );
  }
}