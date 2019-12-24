import 'dart:async';

import 'package:movie_app/data/model/movieDetails_data.dart';

import '../network_common.dart';

class MovieDetailsRepository {

  const MovieDetailsRepository();
  final _apiKey = "f55fbda0cb73b855629e676e54ab6d8e";

  Future<DetailsModel> getMovieDetails(int id) {
    print("repository :$id");
    return  new NetworkCommon().dio.get("${id.toString()}", queryParameters: {
      "api_key": _apiKey,
    }).then((d) {
      var result= new NetworkCommon().decodeResp(d);
      return DetailsModel.fromJSON(result);
    });
  }
}