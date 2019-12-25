import 'dart:async';

import '../network_common.dart';

class TrailersRepository {

  const TrailersRepository();
  final _apiKey = "f55fbda0cb73b855629e676e54ab6d8e";

  Future<Map> getTrailers(int id) {
    return  new NetworkCommon().dio.get("${id.toString()}/videos", queryParameters: {
      "api_key": _apiKey,
    }).then((d) {
      return new NetworkCommon().decodeResp(d) as Map;
    });
  }
}