import 'package:meta/meta.dart';
import 'package:movie_app/data/model/movieDetails_data.dart';
import 'package:movie_app/redux/action_report.dart';

class MovieDetailsState {
  final DetailsModel detailsModel;
  final Map<String, DetailsModel> detailsModels;
  final Map<String, ActionReport> status;

  MovieDetailsState({
    @required this.detailsModels,
    @required this.detailsModel,
    @required this.status,
  });

  MovieDetailsState copyWith({
    DetailsModel detailsModel,
    Map<String, DetailsModel> detailsModels,
    Map<String, ActionReport> status,
  }) {
    return MovieDetailsState(
      detailsModels: detailsModels ?? this.detailsModels ?? Map(),
      detailsModel: detailsModel ?? this.detailsModel,
      status: status ?? this.status,
    );
  }
}
