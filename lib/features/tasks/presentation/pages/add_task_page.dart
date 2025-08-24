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
  late final TaskController _controller;

  String _title = "";
  String _content = "";
  DateTime? _selectedDate;
  String _priority = "Moyenne";
  bool _isLoading = false;

  final List<String> priorities = ["Élevée", "Moyenne", "Basse"];

  @override
  void initState() {
    super.initState();
    _controller = TaskController(TaskRepository(TaskApiService()));
  }

  Future<void> _pickDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
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

  Future<void> _saveTask() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final task = Task(
        id: "",
        title: _title,
        content: _content,
        date: _selectedDate ?? DateTime.now(),
        priority: _priority,
      );

      setState(() => _isLoading = true);

      try {
        await _controller.addTask(task);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("✅ Tâche ajoutée avec succès")),
          );
          Navigator.pop(context, true);
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Erreur : $e")));
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajouter une tâche")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Titre",
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? "Entrez un titre"
                            : null,
                onSaved: (value) => _title = value!,
              ),
              const SizedBox(height: 16),

              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onSaved: (value) => _content = value ?? "",
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? "Aucune date choisie"
                          : "📅 ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year} "
                              "⏰ ${_selectedDate!.hour}:${_selectedDate!.minute.toString().padLeft(2, '0')}",
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: _pickDateTime,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: "Priorité",
                  border: OutlineInputBorder(),
                ),
                value: _priority,
                items:
                    priorities
                        .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                        .toList(),
                onChanged: (value) => setState(() => _priority = value!),
              ),
              const SizedBox(height: 24),

              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    onPressed: _saveTask,
                    label: const Text("Enregistrer"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
