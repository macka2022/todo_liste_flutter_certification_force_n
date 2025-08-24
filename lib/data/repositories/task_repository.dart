import '../models/task.dart';
import '../services/api/task_api_service.dart';

class TaskRepository {
  final TaskApiService apiService;

  TaskRepository(this.apiService);

  Future<Task> addTask(Task task) async {
    return await apiService.createTask(task);
  }
}
