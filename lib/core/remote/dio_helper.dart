import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    print("dio Init ");
    dio = Dio(BaseOptions(
      baseUrl: 'https://fashionzone.masool.net/api/',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    // String lang = 'en',
    int? sub = 0,
    int? brand = 0,
    String? token = '',
  }) async {
    dio!.options.headers = {
      'Authorization': 'Bearer $token'
      // 'Connection': 'keep-alive',
      // 'Accept-Encoding': "gzip, deflate, br",
      // "Host": "<calculated when request is sent>"
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> getDataWithoutToken({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token = '',
  }) async {
    dio!.options.headers = {
      'lang': lang,
      'Authorization': token == '' ? 'Bearer $token' : '',
      'Content-Type': 'application/json',
    };
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    String? name,
    String? mobile,
    String? email,
    String? password,
    String? phone_email,

    // required String c_password,

    // Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) async {
    dio!.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
    return await dio!.post(url,
        // queryParameters: query,
        data: data);
  }

  // static Future<Response> postDataWithoutToken({
  //   required String url,
  //   Map<String, dynamic>? query,
  //   required Map<String, dynamic> data,
  //   String lang = 'en',
  //   String? token,
  // }) async {
  //   dio!.options.headers = {
  //     'lang': lang,
  //     'Authorization': token ?? '',
  //     'Content-Type': 'application/json',
  //   };
  //   return await dio!.post(
  //     url,
  //     queryParameters: query,
  //     data: data,
  //   );
  // }

  // static Future<Response> putData({
  //   required String url,
  //   Map<String, dynamic>? query,
  //   required Map<String, dynamic> data,
  //   String lang = 'en',
  //   String? token,
  // }) async {
  //   dio!.options.headers = {
  //     'lang': lang,
  //     'Authorization': token ?? '',
  //     'Content-Type': 'application/json',
  //   };
  //   return await dio!.put(
  //     url,
  //     queryParameters: query,
  //     data: data,
  //   );
  // }

  // static Future<Response> removeData({
  //   required String url,
  //   Map<String, dynamic>? query,
  //   required Map<String, dynamic> data,
  //   String lang = 'en',
  //   String? token,
  // }) async {
  //   dio!.options.headers = {
  //     'lang': lang,
  //     'Authorization': token ?? '',
  //     'Content-Type': 'application/json',
  //   };
  //   return await dio!.delete(
  //     url,
  //     queryParameters: query,
  //     data: data,
  //   );
  // }
}
