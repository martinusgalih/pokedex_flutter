import 'package:riverpod/riverpod.dart';
import 'package:dio/dio.dart';
import 'endpoints.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: Endpoints.baseUrl,
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: const Duration(seconds: 20),
  ));
  dio.interceptors.add(LogInterceptor(responseBody: true));
  return dio;
});
