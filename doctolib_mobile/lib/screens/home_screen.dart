import 'package:doctolib_mobile/screens/login_screen.dart';
import 'package:doctolib_mobile/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/appointment_service.dart';
import 'practitioners_screen.dart';

class HomeScreen extends StatelessWidget {
  final auth = AuthService();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accueil"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () async {
              final user = auth.user;

              if (user == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Utilisateur non chargé")),
                );
                return;
              }

              final appointments = await AppointmentService().getMine();

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      ProfileScreen(user: user, appointments: appointments),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await auth.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Bienvenue sur notre plateforme",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Gérez vos rendez-vous en toute simplicité.",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PractitionersScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 20,
                      ),
                    ),
                    child: const Text(
                      "Prendre rendez-vous",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "Pourquoi utiliser notre service ?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const ListTile(
              leading: Icon(Icons.schedule, color: Colors.blue),
              title: Text("Prise de rendez-vous rapide"),
            ),
            const ListTile(
              leading: Icon(Icons.touch_app, color: Colors.blue),
              title: Text("Gestion simple et intuitive"),
            ),
            const ListTile(
              leading: Icon(Icons.access_time, color: Colors.blue),
              title: Text("Disponible 24h/24"),
            ),
          ],
        ),
      ),
    );
  }
}
