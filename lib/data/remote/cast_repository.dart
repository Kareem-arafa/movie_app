import 'dart:async';

import 'package:movie_app/data/model/cast_data.dart';

import '../network_common.dart';

class CastRepository {

  const CastRepository();
  final _apiKey = "f55fbda0cb73b855629e676e54ab6d8e";

  Future<Map> getCasts(int id) {
    return  new NetworkCommon().dio.get("${id.toString()}/credits", queryParameters: {
      "api_key": _apiKey,
    }).then((d) {
      return NetworkCommon().decodeResp(d) as Map;
    });
  }
}