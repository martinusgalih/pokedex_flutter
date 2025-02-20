import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';
import 'dio_provider.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Response> get(String path, {Map<String, dynamic>? params}) async {
    try {
      return await _dio.get(path, queryParameters: params);
    } on DioException catch (e) {
      throw Exception("Error: ${e.message}");
    }
  }

  Future<Response> post(String path, {Map<String, dynamic>? params}) async {
    try {
      return await _dio.post(path, queryParameters: params);
    } on DioException catch (e) {
      throw Exception("Error: ${e.message}");
    }
  }
}

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(ref.read(dioProvider));
});
