package com.example.api_service_todolist.dao.daoImplement;

import com.example.api_service_todolist.dao.TaskService;

import com.example.api_service_todolist.entity.Task;
import com.example.api_service_todolist.repository.TaskRepository;

import com.example.api_service_todolist.user.ApiExecptionHandler;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ImplementTaskService implements TaskService {

    private final TaskRepository taskRepository;

    public ImplementTaskService(TaskRepository taskRepository) {
        this.taskRepository = taskRepository;
    }

    @Override
    public List<Task> findAll() {
        return taskRepository.findAll();
    }

    @Override
    public Task findTaskById(Long id) {
        return taskRepository.findById(id)
                .orElseThrow(() -> new ApiExecptionHandler.UserNotFoundException("Task avec id " + id + " non trouvée"));
    }

    @Override
    public Task findTaskByTitle(String title) {
        return taskRepository.findByTitre(title)
                .orElseThrow(() -> new ApiExecptionHandler.UserNotFoundException("Task avec le titre " + title + " non trouvée"));
    }

    @Override
    public Task addTask(Task task) {
        return taskRepository.save(task);
    }

    @Override
    public Task updateTask(Task task) {
        if (!taskRepository.existsById(task.getId())) {
            throw new RuntimeException("Task avec id " + task.getId() + " non trouvée");
        }
        return taskRepository.save(task);
    }

    @Override
    public void deleteTask(Task task) {
        taskRepository.delete(task);
    }
}
