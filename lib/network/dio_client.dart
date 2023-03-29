import 'package:dio/dio.dart';

class DioClient {
  static Dio build(String baseUrl, String token) {
    final dio = Dio(BaseOptions(baseUrl: baseUrl));
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      print('************************************');
      print(options.baseUrl);
      print(options.uri);
      print('************************************');
      // options.headers['Accept'] = 'application/json';
      options.headers['token'] = token;
      return handler.next(options); //continue
    }, onResponse: (response, handler) {
      print(response);
      // response.data = json.decode(response.data);
      return handler.next(response); // continue
    }, onError: (DioError e, handler) {
      print(e);
      return handler.next(e); //continue
    }));
    return dio;
  }
}
