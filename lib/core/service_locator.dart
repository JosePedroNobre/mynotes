import 'package:dio/dio.dart';
import 'package:mynotes/network/api_service.dart';
import 'package:mynotes/network/error_handling/error_helper.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();

  factory ServiceLocator() {
    return _instance;
  }

  ServiceLocator._internal();

  // Lazy initialization for variables
  ErrorHelper get errorHelper => _errorHelper ??= ErrorHelper();
  static ApiService? _apiService;
  static ErrorHelper? _errorHelper;
  ApiService get apiService => _apiService ??= ApiService(
        dio: Dio(
          BaseOptions(
            headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
            baseUrl: 'BaseURL',
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            sendTimeout: const Duration(seconds: 90),
          ),
        ),
      );
}
