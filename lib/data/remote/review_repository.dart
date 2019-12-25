import 'dart:async';

import 'package:movie_app/data/model/reviwews_data.dart';
import '../network_common.dart';

class ReviewsRepository {

  const ReviewsRepository();
  final _apiKey = "f55fbda0cb73b855629e676e54ab6d8e";

  Future<ReviewModel> getReviews(int id) {
    return  new NetworkCommon().dio.get("${id.toString()}/reviews", queryParameters: {
      "api_key": _apiKey,
    }).then((d) {
      print(d.toString());
      var result= NetworkCommon().decodeResp(d);
      return ReviewModel.fromJson(result) ;
    });
  }
}