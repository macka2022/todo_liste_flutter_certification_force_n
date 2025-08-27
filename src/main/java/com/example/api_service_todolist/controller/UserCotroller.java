package com.example.api_service_todolist.controller;

import com.example.api_service_todolist.dao.UserService;
import com.example.api_service_todolist.entity.Utilisateur;
import com.example.api_service_todolist.response.ResponseHandler;
import com.example.api_service_todolist.user.ApiExecptionHandler;
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
@RequestMapping("/user")
public class UserCotroller {

    private final UserService userService;
    private static final Logger logger = LoggerFactory.getLogger(UserCotroller.class);

    public UserCotroller(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/inscription")
    public ResponseEntity<Object> createUser(@Valid @RequestBody Utilisateur user, BindingResult result) {
        if (result.hasErrors()) {
            List<String> errors = result.getAllErrors()
                    .stream()
                    .map(DefaultMessageSourceResolvable::getDefaultMessage)
                    .toList();
            return ResponseEntity.badRequest().body(errors);
        }

        try {
            return ResponseHandler.ResponseBuilder("Ajouté utilisateur", HttpStatus.OK, userService.CreateUser(user));
        } catch (ApiExecptionHandler.UserNotFoundException e) {
            return ResponseHandler.ResponseBuilder(e.getMessage(), HttpStatus.NOT_FOUND, null);
        } catch (org.springframework.dao.DataAccessException e) {
            logger.error("Erreur d'accès à la base de données", e);
            return ResponseHandler.ResponseBuilder("Erreur interne : problème d'accès aux données",
                    HttpStatus.INTERNAL_SERVER_ERROR, null);
        } catch (org.springframework.web.client.RestClientException e) {
            logger.error("Erreur de connexion à un service externe", e);
            return ResponseHandler.ResponseBuilder("Erreur réseau ou service indisponible",
                    HttpStatus.SERVICE_UNAVAILABLE, null);
        } catch (Exception e) {
            logger.error("Erreur interne inattendue", e);
            return ResponseHandler.ResponseBuilder("Une erreur interne s'est produite",
                    HttpStatus.INTERNAL_SERVER_ERROR, null);
        }
    }

    @GetMapping("/listuser")
    public ResponseEntity<Object> listUser() {
        try {
            return ResponseHandler.ResponseBuilder("Liste des utilisateurs", HttpStatus.OK, userService.listUser());
        } catch (ApiExecptionHandler.UserNotFoundException e) {
            return ResponseHandler.ResponseBuilder(e.getMessage(), HttpStatus.NOT_FOUND, null);
        } catch (org.springframework.dao.DataAccessException e) {
            logger.error("Erreur d'accès à la base de données", e);
            return ResponseHandler.ResponseBuilder("Erreur interne : problème d'accès aux données",
                    HttpStatus.INTERNAL_SERVER_ERROR, null);
        } catch (org.springframework.web.client.RestClientException e) {
            logger.error("Erreur de connexion à un service externe", e);
            return ResponseHandler.ResponseBuilder("Erreur réseau ou service indisponible",
                    HttpStatus.SERVICE_UNAVAILABLE, null);
        } catch (Exception e) {
            logger.error("Erreur interne inattendue", e);
            return ResponseHandler.ResponseBuilder("Une erreur interne s'est produite",
                    HttpStatus.INTERNAL_SERVER_ERROR, null);
        }
    }


    @GetMapping("/{id}")
    public ResponseEntity<Object> findUserById(@PathVariable Long id) {
        try {
            Utilisateur user = userService.findUserById(id);
            return ResponseHandler.ResponseBuilder("Utilisateur trouvé", HttpStatus.OK, user);
        } catch (ApiExecptionHandler.UserNotFoundException e) {
            return ResponseHandler.ResponseBuilder(e.getMessage(), HttpStatus.NOT_FOUND, null);
        } catch (Exception e) {
            logger.error("Erreur interne inattendue", e);
            return ResponseHandler.ResponseBuilder("Une erreur interne s'est produite",
                    HttpStatus.INTERNAL_SERVER_ERROR, null);
        }
    }


    @PutMapping("/update")
    public ResponseEntity<Object> updateUser(@Valid @RequestBody Utilisateur user, BindingResult result) {
        if (result.hasErrors()) {
            List<String> errors = result.getAllErrors()
                    .stream()
                    .map(DefaultMessageSourceResolvable::getDefaultMessage)
                    .toList();
            return ResponseEntity.badRequest().body(errors);
        }

        try {
            Utilisateur updatedUser = userService.update(user);
            return ResponseHandler.ResponseBuilder("Utilisateur mis à jour", HttpStatus.OK, updatedUser);
        } catch (ApiExecptionHandler.UserNotFoundException e) {
            return ResponseHandler.ResponseBuilder(e.getMessage(), HttpStatus.NOT_FOUND, null);
        } catch (Exception e) {
            logger.error("Erreur interne inattendue", e);
            return ResponseHandler.ResponseBuilder("Une erreur interne s'est produite",
                    HttpStatus.INTERNAL_SERVER_ERROR, null);
        }
    }
}
