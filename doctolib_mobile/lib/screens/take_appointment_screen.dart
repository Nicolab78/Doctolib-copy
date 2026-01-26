import 'package:flutter/material.dart';
import '../services/user_service.dart';
import '../services/appointment_service.dart';

class TakeAppointmentScreen extends StatefulWidget {
  final String practitionerId;

  const TakeAppointmentScreen({super.key, required this.practitionerId});

  @override
  State<TakeAppointmentScreen> createState() => _TakeAppointmentScreenState();
}

class _TakeAppointmentScreenState extends State<TakeAppointmentScreen> {
  Map<String, dynamic>? practitioner;
  Map<String, dynamic>? me;

  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String selectedType = "PRESENTIEL";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    me = await UserService().getMe();
    practitioner = await UserService().getById(widget.practitionerId);
    setState(() {});
  }

  Future<void> submit() async {
    if (selectedDate == null || selectedTime == null) return;

    final date = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    final data = {
      "patientId": me!['id'].toString(),
      "practitionerId": widget.practitionerId.toString(),
      "date": date.toUtc().toIso8601String(),
      "type": selectedType, // "VISIO" ou "PRESENTIEL"
    };

    try {
      await AppointmentService().create(data);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Rendez-vous confirmé")));
        Navigator.pop(context);
      }
    } catch (e) {
      print("Erreur: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (practitioner == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Prendre rendez-vous")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text(
                  "${practitioner!['firstname']} ${practitioner!['lastname']}",
                ),
                subtitle: Text("Spécialité : ${practitioner!['specialty']}"),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final d = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  initialDate: DateTime.now(),
                );
                if (d != null) setState(() => selectedDate = d);
              },
              child: Text(
                selectedDate == null
                    ? "Choisir une date"
                    : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final t = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (t != null) setState(() => selectedTime = t);
              },
              child: Text(
                selectedTime == null
                    ? "Choisir une heure"
                    : "${selectedTime!.hour}h${selectedTime!.minute.toString().padLeft(2, '0')}",
              ),
            ),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedType,
              items: const [
                DropdownMenuItem(
                  value: "PRESENTIEL",
                  child: Text("Présentiel"),
                ),
                DropdownMenuItem(value: "VISIO", child: Text("Visio")),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedType = value);
                }
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: submit,
              child: const Text("Confirmer le rendez-vous"),
            ),
          ],
        ),
      ),
    );
  }
}
