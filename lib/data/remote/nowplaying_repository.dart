import 'dart:async';
import 'package:dio/dio.dart';
import 'package:movie_app/data/model/nowplaying_data.dart';
import 'package:movie_app/data/network_common.dart';

class NowPlayingRepository {
  const NowPlayingRepository();
  final _apiKey = "f55fbda0cb73b855629e676e54ab6d8e";

  Future<Map> getNowPlayingsList(int page) {
    return  new NetworkCommon().dio.get("now_playing", queryParameters: {
      "page": page,
      "api_key": _apiKey,
    }).then((d) {
      print(d.toString());
      return new NetworkCommon().decodeResp(d) as Map;
      //   return results;
    });
  }

  Future<NowPlaying> createNowPlaying(NowPlaying nowplaying) {
    var dio = new NetworkCommon().dio;
    dio.options.headers.putIfAbsent("Accept", () {
      return "application/json";
    });
    return dio.post("nowplaying/", data: nowplaying).then((d) {
      var results = new NetworkCommon().decodeResp(d);

      return new NowPlaying.fromJson(results);
    });
  }

  Future<NowPlaying> updateNowPlaying(NowPlaying nowplaying) {
    var dio = new NetworkCommon().dio;
    dio.options.headers.putIfAbsent("Accept", () {
      return "application/json";
    });
    return dio.put("nowplaying/", data: nowplaying).then((d) {
      var results = new NetworkCommon().decodeResp(d);

      return new NowPlaying.fromJson(results);
    });
  }

  Future<int> deleteNowPlaying(int id) {
    return new NetworkCommon().dio.delete("nowplaying/", queryParameters: {"id": id}).then((d) {
      var results = new NetworkCommon().decodeResp(d);

      return 0;
    });
  }

  Future<NowPlaying> getNowPlaying(int id) {
    return new NetworkCommon().dio.get("nowplaying/", queryParameters: {"id": id}).then((d) {
      var results = new NetworkCommon().decodeResp(d);

      return new NowPlaying.fromJson(results);
    });
  }

}
