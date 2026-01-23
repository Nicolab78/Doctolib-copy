import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  final auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Accueil")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await auth.logout();
            Navigator.pop(context);
          },
          child: Text("Se déconnecter"),
        ),
      ),
    );
  }
}
