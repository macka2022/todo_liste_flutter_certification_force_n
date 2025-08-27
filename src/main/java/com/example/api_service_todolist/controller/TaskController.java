package com.example.api_service_todolist.controller;



import com.example.api_service_todolist.dao.TaskService;
import com.example.api_service_todolist.entity.Task;
import com.example.api_service_todolist.response.ResponseHandler;
import jakarta.validation.Valid;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.support.DefaultMessageSourceResolvable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/task")
public class TaskController {

    private final TaskService taskService;
    private static final Logger logger = LoggerFactory.getLogger(TaskController.class);

    public TaskController(TaskService taskService) {
        this.taskService = taskService;
    }

    // 🔹 Ajouter une tâche
    @PostMapping("/add")
    public ResponseEntity<Object> addTask(@Valid @RequestBody Task task, BindingResult result) {
        if (result.hasErrors()) {
            List<String> errors = result.getAllErrors()
                    .stream()
                    .map(DefaultMessageSourceResolvable::getDefaultMessage)
                    .toList();
            return ResponseEntity.badRequest().body(errors);
        }

        try {
            return ResponseHandler.ResponseBuilder("Tâche ajoutée avec succès", HttpStatus.CREATED, taskService.addTask(task));
        } catch (Exception e) {
            logger.error("Erreur lors de l'ajout de la tâche", e);
            return ResponseHandler.ResponseBuilder("Erreur interne", HttpStatus.INTERNAL_SERVER_ERROR, null);
        }
    }

    // 🔹 Liste de toutes les tâches
    @GetMapping("/list")
    public ResponseEntity<Object> listTasks() {
        try {
            return ResponseHandler.ResponseBuilder("Liste des tâches", HttpStatus.OK, taskService.findAll());
        } catch (Exception e) {
            logger.error("Erreur lors de la récupération des tâches", e);
            return ResponseHandler.ResponseBuilder("Erreur interne", HttpStatus.INTERNAL_SERVER_ERROR, null);
        }
    }

    // 🔹 Trouver une tâche par ID
    @GetMapping("/{id}")
    public ResponseEntity<Object> getTaskById(@PathVariable Long id) {
        try {
            return ResponseHandler.ResponseBuilder("Tâche trouvée", HttpStatus.OK, taskService.findTaskById(id));
        } catch (RuntimeException e) {
            return ResponseHandler.ResponseBuilder(e.getMessage(), HttpStatus.NOT_FOUND, null);
        } catch (Exception e) {
            logger.error("Erreur lors de la récupération de la tâche", e);
            return ResponseHandler.ResponseBuilder("Erreur interne", HttpStatus.INTERNAL_SERVER_ERROR, null);
        }
    }

    // 🔹 Trouver une tâche par titre
    @GetMapping("/title/{title}")
    public ResponseEntity<Object> getTaskByTitle(@PathVariable String title) {
        try {
            return ResponseHandler.ResponseBuilder("Tâche trouvée", HttpStatus.OK, taskService.findTaskByTitle(title));
        } catch (RuntimeException e) {
            return ResponseHandler.ResponseBuilder(e.getMessage(), HttpStatus.NOT_FOUND, null);
        } catch (Exception e) {
            logger.error("Erreur lors de la récupération de la tâche par titre", e);
            return ResponseHandler.ResponseBuilder("Erreur interne", HttpStatus.INTERNAL_SERVER_ERROR, null);
        }
    }

    // 🔹 Mettre à jour une tâche
    @PutMapping("/update")
    public ResponseEntity<Object> updateTask(@Valid @RequestBody Task task, BindingResult result) {
        if (result.hasErrors()) {
            List<String> errors = result.getAllErrors()
                    .stream()
                    .map(DefaultMessageSourceResolvable::getDefaultMessage)
                    .toList();
            return ResponseEntity.badRequest().body(errors);
        }

        try {
            return ResponseHandler.ResponseBuilder("Tâche mise à jour avec succès", HttpStatus.OK, taskService.updateTask(task));
        } catch (RuntimeException e) {
            return ResponseHandler.ResponseBuilder(e.getMessage(), HttpStatus.NOT_FOUND, null);
        } catch (Exception e) {
            logger.error("Erreur lors de la mise à jour de la tâche", e);
            return ResponseHandler.ResponseBuilder("Erreur interne", HttpStatus.INTERNAL_SERVER_ERROR, null);
        }
    }

    // 🔹 Supprimer une tâche
    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Object> deleteTask(@PathVariable Long id) {
        try {
            Task task = taskService.findTaskById(id); // vérifier existence
            taskService.deleteTask(task);
            return ResponseHandler.ResponseBuilder("Tâche supprimée avec succès", HttpStatus.OK, null);
        } catch (RuntimeException e) {
            return ResponseHandler.ResponseBuilder(e.getMessage(), HttpStatus.NOT_FOUND, null);
        } catch (Exception e) {
            logger.error("Erreur lors de la suppression de la tâche", e);
            return ResponseHandler.ResponseBuilder("Erreur interne", HttpStatus.INTERNAL_SERVER_ERROR, null);
        }
    }
}
