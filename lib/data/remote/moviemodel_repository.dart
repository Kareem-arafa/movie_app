import 'dart:async';
import 'package:dio/dio.dart';
import 'package:movie_app/data/model/moviemodel_data.dart';
import 'package:movie_app/data/model/page_data.dart';
import 'package:movie_app/data/network_common.dart';
import 'package:movie_app/features/movie/movie_view_model.dart';

class MovieModelRepository {
  const MovieModelRepository();
  final _apiKey = "f55fbda0cb73b855629e676e54ab6d8e";

  Future<Map> getMovieModelsList(int page) {
    print("popular?api_key=$_apiKey&page=${Page().currPage}");
    return  new NetworkCommon().dio.get("popular", queryParameters: {
      "page": page,
      "api_key": _apiKey,
    }).then((d) {
      print(d.toString());
      return new NetworkCommon().decodeResp(d) as Map;
   //   return results;
    });
  }
  Future<Map> getNowMovieModelsList(int page) {

    return  new NetworkCommon().dio.get("now_playing", queryParameters: {
      "page": page,
      "api_key": _apiKey,
    }).then((d) {
      print(d.toString());
      return new NetworkCommon().decodeResp(d) as Map;
      //   return results;
    });
  }

  Future<MovieModel> createMovieModel(MovieModel moviemodel) {
    var dio = new NetworkCommon().dio;
    dio.options.headers.putIfAbsent("Accept", () {
      return "application/json";
    });
    return dio.post("moviemodel/", data: moviemodel).then((d) {
      var results = new NetworkCommon().decodeResp(d);

      return new MovieModel.fromJson(results);
    });
  }

  Future<MovieModel> updateMovieModel(MovieModel moviemodel) {
    var dio = new NetworkCommon().dio;
    dio.options.headers.putIfAbsent("Accept", () {
      return "application/json";
    });
    return dio.put("moviemodel/", data: moviemodel).then((d) {
      var results = new NetworkCommon().decodeResp(d);

      return new MovieModel.fromJson(results);
    });
  }

  Future<int> deleteMovieModel(int id) {
    return new NetworkCommon().dio.delete("moviemodel/", queryParameters: {"id": id}).then((d) {
      var results = new NetworkCommon().decodeResp(d);

      return 0;
    });
  }

  Future<MovieModel> getMovieModel(int id) {
    return new NetworkCommon().dio.get("moviemodel/", queryParameters: {"id": id}).then((d) {
      var results = new NetworkCommon().decodeResp(d);

      return new MovieModel.fromJson(results);
    });
  }

}
