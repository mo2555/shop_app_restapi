import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type':'application/json',
          'lang':'en'
        },
      ),
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String? lang = 'en',
    String? token,
  }) async {
    DioHelper.init();
    dio.options.headers = {
      'lang':lang,
      'Authorization':token,
      'Content-Type':'application/json',
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required String url,
     Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? lang = 'en',
    String? token
  }) async {
    DioHelper.init();
    dio.options.headers = {
      'lang':lang,
      'Authorization':token,
      'Content-Type':'application/json',
    };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> updateData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String? lang = 'en',
    String? token,
  }) async {
    DioHelper.init();
    dio.options.headers = {
      'lang':lang,
      'Authorization':token,
      'Content-Type':'application/json',
    };
    return await dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}