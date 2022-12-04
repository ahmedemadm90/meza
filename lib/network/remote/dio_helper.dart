import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:meza/network/local/cache_helper.dart';
import 'package:meza/network/remote/endpoints.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(BaseOptions(
      baseUrl: BaseURL,
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${CacheHelper.getData('token')}',
    };
    return await dio!.get(url, queryParameters: query ?? null);
  }

  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      //'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ${CacheHelper.getData('token')}',
    };
    return await dio!.post(url, queryParameters: query, data: data);
  }

  static Future<Response> registerData({
    required String url,
    required FormData? data,
  }) async {
    dio!.options.headers = {
      "Accept": "application/json",
      //"Content-Type": "multipart/form-data",
    };
    return await dio!.post(url, data: data);
  }
}
