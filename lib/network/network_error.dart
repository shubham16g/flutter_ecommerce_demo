import 'package:dio/dio.dart';

class NetworkError {
  static const int unknownError = 888;

  final int status;
  final String message;

  NetworkError(this.status, this.message);

  NetworkError.from(Object obj)
      : status = obj.runtimeType is DioError
            ? (obj as DioError).response?.statusCode ?? unknownError
            : obj.runtimeType is NetworkError
                ? (obj as NetworkError).status
                : unknownError,
        message = obj.runtimeType is DioError
            ? (obj as DioError).response?.statusMessage ?? ''
            : obj.runtimeType is NetworkError
                ? (obj as NetworkError).message
                : 'Unknown error';
}
