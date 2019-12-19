import 'dart:async';

import '../network_common.dart';

class UpComingRepository {
  const UpComingRepository();
  final _apiKey = "f55fbda0cb73b855629e676e54ab6d8e";

  Future<Map> getMovieModelsList(int page) {
    return  new NetworkCommon().dio.get("upcoming", queryParameters: {
      "page": page,
      "api_key": _apiKey,
    }).then((d) {
      print(d.toString());
      return new NetworkCommon().decodeResp(d) as Map;
      //   return results;
    });
  }
}