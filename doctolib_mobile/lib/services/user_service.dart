import 'package:dio/dio.dart';
import '../api/dio_client.dart';

class UserService {
  Future<Map<String, dynamic>> getMe() async {
    final dio = await DioClient.withToken();
    final response = await dio.get("/auth/me");
    return response.data;
  }

  Future<Map<String, dynamic>> getById(String id) async {
    final dio = await DioClient.withToken();
    final response = await dio.get("/users/$id");
    return response.data;
  }

  Future<List<dynamic>> getAllPractitioners() async {
    final dio = await DioClient.withToken();
    final response = await dio.get("/users/practitioners");
    return response.data;
  }

  Future<Map<String, dynamic>> create(Map<String, dynamic> data) async {
    final dio = DioClient.dio;
    final response = await dio.post("/users", data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> update(
    String id,
    Map<String, dynamic> data,
  ) async {
    final dio = await DioClient.withToken();
    final response = await dio.put("/users/$id", data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> updateSpecialty(String specialty) async {
    final dio = await DioClient.withToken();
    final response = await dio.put(
      "/users/me/specialty",
      data: {"specialty": specialty},
    );
    return response.data;
  }
}
