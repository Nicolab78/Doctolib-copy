import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final firstnameCtrl = TextEditingController();
  final lastnameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  String selectedRole = "PATIENT";

  final auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Créer un compte")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: firstnameCtrl,
              decoration: const InputDecoration(labelText: "Prénom"),
            ),
            TextField(
              controller: lastnameCtrl,
              decoration: const InputDecoration(labelText: "Nom"),
            ),
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: passCtrl,
              decoration: const InputDecoration(labelText: "Mot de passe"),
              obscureText: true,
            ),
            TextField(
              controller: phoneCtrl,
              decoration: const InputDecoration(
                labelText: "Téléphone (optionnel)",
              ),
            ),

            const SizedBox(height: 20),

            DropdownButton<String>(
              value: selectedRole,
              items: const [
                DropdownMenuItem(value: "PATIENT", child: Text("Patient")),
                DropdownMenuItem(
                  value: "PRACTITIONER",
                  child: Text("Praticien"),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedRole = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                await auth.register(
                  email: emailCtrl.text,
                  password: passCtrl.text,
                  firstname: firstnameCtrl.text,
                  lastname: lastnameCtrl.text,
                  phone: phoneCtrl.text.isEmpty ? null : phoneCtrl.text,
                  role: selectedRole,
                );

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => HomeScreen()),
                );
              },
              child: const Text("Créer le compte"),
            ),

            const SizedBox(height: 10),

            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                );
              },
              child: const Text("Déjà un compte ? Se connecter"),
            ),
          ],
        ),
      ),
    );
  }
}
