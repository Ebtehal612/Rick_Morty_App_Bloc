import 'package:dio/dio.dart';

import '../../consts/strings.dart';

class CharWeb {
  late Dio dio;
  CharWeb() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    );
    dio = Dio(options);
    dio.interceptors.addAll([
      LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
        error: true,
        responseHeader: true,
      )
    ]);
  }

  Future<Map<String, dynamic>> getAllChar() async {
    try {
      Response response = await dio.get('character');
      return response.data;
    } catch (e) {
      return {};
    }
  }
}
