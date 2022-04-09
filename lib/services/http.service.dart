import 'dart:io';

import 'package:adeo_app/constants/api.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class HttpService {
  String host = Api.baseUrl;
  BaseOptions baseOptions;
  Dio dio;

  Future<Map<String, String>> getHeaders() async {
    return {
      HttpHeaders.acceptHeader: "application/json",
      HttpHeaders.contentTypeHeader: 'application/json',
    };
  }

  HttpService() {
    baseOptions = BaseOptions(
      baseUrl: host,
      validateStatus: (status) {
        return status <= 500;
      },
    );
    dio = Dio(baseOptions);

    dio.interceptors.add(DioCacheManager(
      CacheConfig(
        baseUrl: host,
        defaultMaxAge: const Duration(days: 3),
      ),
    ).interceptor);
  }

  Future<Response> get(String url,
      {Map<String, dynamic> queryParameters, CancelToken token}) async {
    String uri = "$host$url";
    print(uri);
    return dio.get(
      uri,
      options: Options(
        headers: await getHeaders(),
      ),
      queryParameters: queryParameters,
    );
  }
}
