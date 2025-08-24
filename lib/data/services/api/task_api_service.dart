import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../core/api_constants.dart';
import '../../models/task.dart';

class TaskApiService {
  final String baseUrl = ApiConstants.baseUrl;

  Future<Task> createTask(Task task) async {
    final response = await http.post(
      Uri.parse("$baseUrl/tasks"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(task.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Task.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Erreur lors de l'ajout (${response.statusCode})");
    }
  }
}
