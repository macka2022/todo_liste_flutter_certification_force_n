package com.example.api_service_todolist.user;

public class ApiRequestException extends  RuntimeException {
    public ApiRequestException(String message){
        super(message);
    }
    public ApiRequestException(String message, Throwable cause){
        super(message, cause );
    }


}