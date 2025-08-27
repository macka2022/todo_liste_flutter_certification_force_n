package com.example.api_service_todolist.repository;

import com.example.api_service_todolist.entity.Task;
import org.springframework.data.jpa.repository.JpaRepository;
//import org.springframework.scheduling.config.Task;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface TaskRepository extends JpaRepository<Task, Long> {
    Optional<Task> findByTitre(String title);
}
