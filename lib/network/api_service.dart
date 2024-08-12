import 'package:dio/dio.dart';
import 'package:mynotes/core/service_locator.dart';
import 'package:mynotes/network/api_service_interceptor.dart';

class ApiService {
  final Dio dio;

  ApiService({required this.dio}) {
    if (dio.interceptors.whereType<ApiServiceInterceptor>().isEmpty) {
      dio.interceptors.add(ApiServiceInterceptor());
    }
  }

  Future<dynamic> get(String url, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(dio.options.baseUrl + url, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(String url, {dynamic data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.post(dio.options.baseUrl + url, data: data, queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> put(String url, {dynamic data}) async {
    final response = await dio.put(dio.options.baseUrl + url, data: data);
    return response;
  }

  Future<dynamic> delete(String url, {dynamic data}) async {
    final response = await dio.delete(dio.options.baseUrl + url, data: data);
    return response;
  }

  Future<dynamic> patch(String url, {dynamic data}) async {
    final response = await dio.patch(dio.options.baseUrl + url, data: data);
    return response;
  }
}

class OCBServiceInterceptor extends Interceptor {
  final _errorHelper = ServiceLocator().errorHelper;
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Check if err.response is null before accessing its properties
    if (err.response != null) {
      // Your error handling logic
      _errorHelper.broadcastError('Sorry, something went wrong');
    } else {
      // Handle the case where err.response is null
      _errorHelper.broadcastError('Sorry, something went wrong');
    }
  }
}
