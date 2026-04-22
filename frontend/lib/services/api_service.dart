import 'package:dio/dio.dart';

class ApiService {
  ApiService({String? baseUrl})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl ?? 'http://localhost:5000/api',
            connectTimeout: const Duration(seconds: 12),
            receiveTimeout: const Duration(seconds: 12),
          ),
        );

  final Dio _dio;

  void setAuthToken(String? token) {
    if (token == null || token.isEmpty) {
      _dio.options.headers.remove('Authorization');
      return;
    }
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  Future<Map<String, dynamic>> signup(
      String name, String email, String password) async {
    final res = await _dio.post('/auth/signup', data: {
      'name': name,
      'email': email,
      'password': password,
    });
    return Map<String, dynamic>.from(res.data);
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final res = await _dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    return Map<String, dynamic>.from(res.data);
  }

  Future<Map<String, dynamic>> verifyClaim(
      String text, String sourceType) async {
    final res = await _dio.post('/claim/verify', data: {
      'claimText': text,
      'sourceType': sourceType,
    });
    return Map<String, dynamic>.from(res.data);
  }

  Future<List<dynamic>> getHistory() async {
    final res = await _dio.get('/claim/history');
    return (res.data as List<dynamic>);
  }

  Future<List<dynamic>> getTrending() async {
    final res = await _dio.get('/claim/trending');
    return (res.data as List<dynamic>);
  }
}
