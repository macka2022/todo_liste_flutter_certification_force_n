package com.example.api_service_todolist.user;


import org.springframework.http.HttpStatus;

import java.time.ZonedDateTime;



public class ApiException {
    private final String message;

    private final HttpStatus httpstatus;

    public ApiException(String message, HttpStatus httpstatus) {
        this.message = message;


        this.httpstatus = httpstatus;
    }



    public String getMessage() {
        return message;
    }





    public HttpStatus getHttpstatus() {
        return httpstatus;
    }
}
