import 'package:flutter/material.dart';
import '../../../../data/models/task.dart';
import '../../../../data/services/api/task_api_service.dart';
import '../../../../data/repositories/task_repository.dart';
import '../../../tasks/controllers/task_controller.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  String _content = "";
  String _priority = "Moyenne";
  DateTime? _selectedDate;

  final List<String> priorities = ["Élevée", "Moyenne", "Basse"];

  Future<void> _pickDateTime() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("✅ Tâche ajoutée")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 🔹 Header avec image et texte
            Container(
              width: double.infinity,
              height: 400,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/header.jpeg"), // ton image
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.4),
                child: Center(
                  child: Text(
                    "RÉALISE TES RÊVES",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),

            /// 🔹 Formulaire
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    /// Champ titre
                    TextFormField(
                      decoration: _inputStyle("Faire de java"),
                      validator:
                          (v) => v == null || v.isEmpty ? "Titre requis" : null,
                      onSaved: (v) => _title = v!,
                    ),
                    const SizedBox(height: 16),

                    /// Champ description
                    TextFormField(
                      decoration: _inputStyle("Exercice 1 à 5 page 56"),
                      maxLines: 2,
                      onSaved: (v) => _content = v ?? "",
                    ),
                    const SizedBox(height: 16),

                    /// Dropdown priorité
                    DropdownButtonFormField(
                      decoration: _inputStyle("Élevée / Moyenne / Basse"),
                      value: _priority,
                      items:
                          priorities
                              .map(
                                (p) =>
                                    DropdownMenuItem(value: p, child: Text(p)),
                              )
                              .toList(),
                      onChanged: (v) => setState(() => _priority = v!),
                    ),
                    const SizedBox(height: 16),

                    /// Sélecteur Date & Heure
                    InkWell(
                      onTap: _pickDateTime,
                      child: InputDecorator(
                        decoration: _inputStyle("Date°Heure"),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _selectedDate == null
                                  ? "Choisir une date"
                                  : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year} "
                                      "à ${_selectedDate!.hour}:${_selectedDate!.minute.toString().padLeft(2, "0")}",
                            ),
                            const Icon(Icons.calendar_today),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),

                    /// Bouton ajouter
                    ElevatedButton(
                      onPressed: _saveTask,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: Colors.black),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        "J’ajoute",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Style uniforme des champs
  InputDecoration _inputStyle(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
