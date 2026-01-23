import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final _storage = const FlutterSecureStorage();

  Future<void> save(String token) => _storage.write(key: "token", value: token);

  Future<String?> read() => _storage.read(key: "token");

  Future<void> clear() => _storage.delete(key: "token");
}
