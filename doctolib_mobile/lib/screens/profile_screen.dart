import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../services/appointment_service.dart';

class ProfileScreen extends StatefulWidget {
  final Map<String, dynamic> user;
  final List<dynamic> appointments;

  const ProfileScreen({
    super.key,
    required this.user,
    required this.appointments,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Map<String, dynamic> user;
  late List<dynamic> appointments;

  String specialty = "";
  String message = "";
  bool loading = false;

  final specialties = const [
    "GENERALIST",
    "CARDIOLOGIST",
    "DENTIST",
    "DERMATOLOGIST",
    "PEDIATRICIAN",
    "OPHTALMOLOGIST",
  ];

  @override
  void initState() {
    super.initState();
    user = widget.user;
    appointments = widget.appointments;
    specialty = user["specialty"] ?? "";
  }

  Future<void> update() async {
    setState(() => loading = true);

    try {
      final updated = await UserService().updateSpecialty(specialty);

      setState(() {
        user = updated;
        message = "Spécialité mise à jour";
      });
    } catch (e) {
      setState(() {
        message = "Erreur lors de la mise à jour";
      });
    }

    setState(() => loading = false);
  }

  Future<void> updateStatus(dynamic a) async {
    try {
      await AppointmentService().update(a["id"], {"status": a["status"]});

      setState(() {});
    } catch (e) {
      print("Erreur mise à jour statut : $e");
    }
  }

  String formatDate(String date) {
    final d = DateTime.parse(date);
    return "${d.day}/${d.month}/${d.year} ${d.hour}h${d.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon profil"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nom : ${user['firstname']} ${user['lastname']}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                "Email : ${user['email']}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                "Rôle : ${user['role']}",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),

              if (user["role"] == "PRACTITIONER") ...[
                const Text("Spécialité"),
                const SizedBox(height: 8),
                DropdownButton<String>(
                  value: specialty.isEmpty ? null : specialty,
                  hint: const Text("Choisir une spécialité"),
                  items: specialties
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (v) => setState(() => specialty = v ?? ""),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: loading ? null : update,
                  child: Text(loading ? "..." : "Mettre à jour"),
                ),
                if (message.isNotEmpty) Text(message),
                const SizedBox(height: 20),
              ],

              const Text(
                "Mes rendez-vous",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              for (final a in appointments)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Date : ${formatDate(a['date'])}"),
                        if (a["practitioner"] != null)
                          Text(
                            "Praticien : ${a['practitioner']['firstname']} ${a['practitioner']['lastname']}",
                          ),
                        if (a["patient"] != null)
                          Text(
                            "Patient : ${a['patient']['firstname']} ${a['patient']['lastname']}",
                          ),
                        Text("Statut : ${a['status']}"),

                        if (user["role"] == "PRACTITIONER")
                          DropdownButton<String>(
                            value: a["status"],
                            items: const [
                              DropdownMenuItem(
                                value: "SCHEDULED",
                                child: Text("Programmé"),
                              ),
                              DropdownMenuItem(
                                value: "CANCELLED",
                                child: Text("Annulé"),
                              ),
                              DropdownMenuItem(
                                value: "DONE",
                                child: Text("Terminé"),
                              ),
                            ],
                            onChanged: (v) {
                              a["status"] = v;
                              updateStatus(a);
                            },
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
