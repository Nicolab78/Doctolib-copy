import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Test API")),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              final dio = Dio(BaseOptions(baseUrl: "http://localhost:3000"));

              try {
                final response = await dio.get("/users/all");
                print("Réponse backend : ${response.data}");
              } catch (e) {
                print("Erreur : $e");
              }
            },
            child: const Text("Tester connexion"),
          ),
        ),
      ),
    );
  }
}
