import 'package:flutter/material.dart';
import '../services/user_service.dart';
import 'take_appointment_screen.dart';

class PractitionersScreen extends StatefulWidget {
  const PractitionersScreen({super.key});

  @override
  State<PractitionersScreen> createState() => _PractitionersScreenState();
}

class _PractitionersScreenState extends State<PractitionersScreen> {
  List<dynamic> practitioners = [];
  String search = "";
  String specialty = "";

  final specialties = [
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
    loadPractitioners();
  }

  Future<void> loadPractitioners() async {
    practitioners = await UserService().getAllPractitioners();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final filtered = practitioners.where((p) {
      final matchName = "${p['firstname']} ${p['lastname']}"
          .toLowerCase()
          .contains(search.toLowerCase());

      final matchSpecialty = specialty.isEmpty || p['specialty'] == specialty;

      return matchName && matchSpecialty;
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Nos praticiens")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "Rechercher un praticien...",
                    ),
                    onChanged: (v) => setState(() => search = v),
                  ),
                ),
                const SizedBox(width: 16),
                DropdownButton<String>(
                  value: specialty.isEmpty ? null : specialty,
                  hint: const Text("Spécialité"),
                  items: specialties
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (v) => setState(() => specialty = v ?? ""),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final p = filtered[index];
                  return Card(
                    child: ListTile(
                      title: Text("${p['firstname']} ${p['lastname']}"),
                      subtitle: Text(p['specialty']),
                      trailing: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TakeAppointmentScreen(
                                practitionerId: p['id'],
                              ),
                            ),
                          );
                        },
                        child: const Text("Prendre rendez-vous"),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
