import '../../../data/models/task.dart';
import '../../../data/repositories/task_repository.dart';

class TaskController {
  final TaskRepository repository;

  TaskController(this.repository);

  Future<Task> addTask(Task task) async {
    return await repository.addTask(task);
  }
}
