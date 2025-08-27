package com.example.api_service_todolist.response;


import com.example.api_service_todolist.user.ApiExecptionHandler;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.HashMap;
import java.util.Map;

@RestControllerAdvice
public class ResponseHandler {

    public static ResponseEntity<Object> ResponseBuilder(
            String message, HttpStatus httpStatus, Object responseObject
    ){
        Map<String, Object> response = new HashMap<>();
        response.put("message", message);
        response.put("status", httpStatus);
        response.put("data", responseObject);
        return new ResponseEntity<>(response, httpStatus);
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Object> handleValidationExceptions(MethodArgumentNotValidException ex) {
        Map<String, String> errors = new HashMap<>();
        ex.getBindingResult().getFieldErrors()
                .forEach(error -> errors.put(error.getField(), error.getDefaultMessage()));

        return ResponseHandler.ResponseBuilder("Erreur de validation", HttpStatus.BAD_REQUEST, errors);
    }

    // 404 Not Found
    @ExceptionHandler(ApiExecptionHandler.UserNotFoundException.class)
    public ResponseEntity<Object> handleUserNotFound(ApiExecptionHandler.UserNotFoundException ex) {
        return ResponseHandler.ResponseBuilder(ex.getMessage(), HttpStatus.NOT_FOUND, null);
    }

    // 409 Conflict - utilisateur déjà existant
    @ExceptionHandler(ApiExecptionHandler.UserAlreadyExistsException.class)
    public ResponseEntity<Object> handleUserAlreadyExists(ApiExecptionHandler.UserAlreadyExistsException ex) {
        return ResponseHandler.ResponseBuilder(ex.getMessage(), HttpStatus.CONFLICT, null);
    }

    // 500 Internal Server Error - autres exceptions

    @ExceptionHandler(Exception.class)
    public ResponseEntity<Object> handleGlobalException(Exception ex) {
        return ResponseHandler.ResponseBuilder("Erreur interne du serveur : " + ex.getMessage(),
                HttpStatus.INTERNAL_SERVER_ERROR, null);
    }

}
