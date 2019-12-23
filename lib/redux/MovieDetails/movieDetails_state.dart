import 'package:meta/meta.dart';
import 'package:movie_app/data/model/movieDetails_data.dart';
import 'package:movie_app/data/model/page_data.dart';
import 'package:movie_app/redux/action_report.dart';

class MovieDetailsState {
  final DetailsModel detailsModel;
  final Map<String, DetailsModel> detailsModels;
  final Map<String, ActionReport> status;
  final Page page;

  MovieDetailsState({
    @required this.detailsModels,
    @required this.detailsModel,
    @required this.status,
    @required this.page,
  });

  MovieDetailsState copyWith({
    DetailsModel detailsModel,
    Map<String, DetailsModel> detailsModels,
    Map<String, ActionReport> status,
    Page page,
  }) {
    return MovieDetailsState(
      detailsModels: detailsModels ?? this.detailsModels ?? Map(),
      detailsModel: detailsModel ?? this.detailsModel,
      status: status ?? this.status,
      page: page ?? this.page,
    );
  }
}
