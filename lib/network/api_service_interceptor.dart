import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:developer';

class DioLogger {
  static List<String> collectedLogs = [];
  static List<String> errorLogs = [];
  static bool collectLogs = false;
  static bool isLogOn = false;

  static void onSuccess(Response response) {
    _printResponse(response);
  }

  static void onError(DioException error) {
    if (null != error.response) {
      _printResponse(error.response!);
    } else {
      log('Error without response: $error ');
    }
  }

  static void _printResponse(Response response) async {
    String curlRequest = 'curl ';

    for (final header in response.requestOptions.headers.keys) {
      curlRequest += '-H "$header: ${response.requestOptions.headers[header]}" ';
    }
    curlRequest += '-X ${response.requestOptions.method} "${response.requestOptions.path}" ';
    if (response.requestOptions.data != null && (response.requestOptions.data is! FormData)) {
      final dataMap = json.encode(response.requestOptions.data);
      curlRequest += '-d \'$dataMap\'';
    }

    log('Request: $curlRequest');

    if (response.requestOptions.data != null) {
      log('RequestBody: ${response.requestOptions.data.toString()} \n');
    }

    final responseData = response.data.toString();

    log('Response: $responseData\n');

    if (collectLogs) {
      collectedLogs.add(curlRequest);
      collectedLogs.add(response.data.toString());
    }

    if ((response.statusCode ?? 0) >= 400) {
      errorLogs.add(curlRequest);
      errorLogs.add(response.data.toString());
    }
  }
}

class ApiServiceInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.headers['Content-Type'] = 'application/json';
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    DioLogger.onSuccess(response);
    super.onResponse(response, handler);
  }

  @override
  dynamic onError(DioException err, ErrorInterceptorHandler handler) async {
    DioLogger.onError(err);
    super.onError(err, handler);
  }
}
