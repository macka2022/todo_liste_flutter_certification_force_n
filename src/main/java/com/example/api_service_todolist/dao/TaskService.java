package com.example.api_service_todolist.dao;



import com.example.api_service_todolist.entity.Task;

import java.util.List;

public interface TaskService {
    public List<Task> findAll();
    public Task findTaskById(Long id);
    public Task findTaskByTitle(String title);
    public Task addTask(Task task);
    public Task updateTask(Task task);
    public void deleteTask(Task task);
}
