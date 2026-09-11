import 'package:MatchIn/core/errors/exceptions.dart';
import 'package:MatchIn/core/networking/api_consumer.dart';
import 'package:MatchIn/core/networking/api_end_points.dart';
import 'package:MatchIn/core/networking/api_interceptor.dart';
import 'package:dio/dio.dart';

/// [DioConsumer] is a class that implements the [ApiConsumer] interface
/// It Implements the main four methods [post], [get], [put], [delete]
class DioConsumer extends ApiConsumer {
  DioConsumer({required this.dio}) {
    //! =================== Configurations ===================
    // takeing base url from api end point
    dio.options.baseUrl = EndPoint.baseUrl;

    // adding api interceptor
    dio.interceptors.add(ApiInterceptor(dio));

    // adding log interceptor
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        requestHeader: false,
        responseHeader: false,
      ),
    );
  }
  final Dio dio; // injecting dio

  //! =================== Methods ===================

  //? ---------- Delete ----------
  @override
  Future delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    bool isFormData = false,
  }) async {
    try {
      final dynamic response = await dio.delete(
        path,
        queryParameters: queryParameters,
        data: isFormData ? FormData.fromMap(data) : data,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  //? ---------- Get ----------
  @override
  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    bool isFormData = false,
  }) async {
    try {
      final dynamic response = await dio.get(
        path,
        queryParameters: queryParameters,
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  //? ---------- Post ----------
  @override
  Future post(
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    bool isFormData = false,
  }) async {
    try {
      final dynamic response = await dio.post(
        path,
        queryParameters: queryParameters,
        data: isFormData ? FormData.fromMap(data) : data,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  //? ---------- Put ----------
  @override
  Future put(
    String path, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
    bool isFormData = false,
  }) async {
    try {
      final dynamic response = await dio.put(
        path,
        queryParameters: queryParameters,
        data: isFormData ? FormData.fromMap(data) : data,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }
}
