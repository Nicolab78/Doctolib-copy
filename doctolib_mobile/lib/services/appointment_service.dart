import 'package:dio/dio.dart';
import '../api/dio_client.dart';

class AppointmentService {
  Future<Map<String, dynamic>> create(Map<String, dynamic> data) async {
    final dio = await DioClient.withToken();
    final response = await dio.post("/appointments/create", data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> update(
    String id,
    Map<String, dynamic> data,
  ) async {
    final dio = await DioClient.withToken();
    final response = await dio.put("/appointments/$id", data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> getById(String id) async {
    final dio = await DioClient.withToken();
    final response = await dio.get("/appointments/$id");
    return response.data;
  }

  Future<List<dynamic>> getMine() async {
    final dio = await DioClient.withToken();
    final response = await dio.get("/appointments/me");
    return response.data;
  }
}
