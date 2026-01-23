import 'package:dio/dio.dart';
import '../storage/token_storage.dart';

class DioClient {
  static final Dio dio = Dio(BaseOptions(baseUrl: "http://localhost:3000"));

  static Future<Dio> withToken() async {
    final token = await TokenStorage().read();

    return Dio(
      BaseOptions(
        baseUrl: "http://localhost:3000",
        headers: {"Authorization": "Bearer $token"},
      ),
    );
  }
}
