import 'package:dio/dio.dart';
import '../api/dio_client.dart';
import '../storage/token_storage.dart';

class AuthService {
  AuthService._internal();
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;

  final _storage = TokenStorage();

  Map<String, dynamic>? user;

  Future<void> login(String email, String password) async {
    final res = await DioClient.dio.post(
      "/auth/login",
      data: {"email": email, "password": password},
    );

    final token = res.data["token"];
    await _storage.save(token);

    user = res.data["user"];
  }

  Future<void> register({
    required String email,
    required String password,
    required String firstname,
    required String lastname,
    String? phone,
    required String role,
  }) async {
    final res = await DioClient.dio.post(
      "/auth/register",
      data: {
        "email": email,
        "password": password,
        "firstname": firstname,
        "lastname": lastname,
        "phone": phone,
        "role": role,
      },
    );

    final token = res.data["token"];
    await _storage.save(token);

    user = res.data["user"];
  }

  Future<Map<String, dynamic>> getMe() async {
    final dio = await DioClient.withToken();
    final res = await dio.get("/auth/me");
    return res.data;
  }

  Future<void> logout() async {
    await _storage.clear();
    user = null;
  }
}
