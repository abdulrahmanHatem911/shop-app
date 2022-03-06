// ignore_for_file: unnecessary_null_in_if_null_operators

import 'package:dio/dio.dart';
// the url

// https://newsapi.org/
// v2/top-headlines?
// country=us&category=business&apiKey=912b495c86b04977ae4bb675b9f3ee3a
class DioHelper {
  static Dio? dio;
  static inIt() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

//-----------------------------------
  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    // momken t3ml  bdl el map dynamic
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return await dio!.get(
      url,
      queryParameters: query,
    );
  }
  // function to post data

  static Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return dio!.post(
      url,
      data: data,
      queryParameters: query,
    );
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return dio!.put(
      url,
      data: data,
      queryParameters: query,
    );
  }
  //putData
}
