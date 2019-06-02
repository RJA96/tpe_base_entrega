package com.bbdd.wms.exceptions;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;

@ControllerAdvice(basePackages = "com.globant.users")
public class GlobalExceptionHandler {

        @ExceptionHandler(Exception.class)
        public String ExceptionHandler(){
            return "error";
        }

        @ResponseStatus(value= HttpStatus.BAD_REQUEST, reason = "Request ID not found")
        @ExceptionHandler(IllegalArgumentException.class)
        public void badIdException(){}

        @ResponseStatus(value = HttpStatus.NOT_ACCEPTABLE, reason = "Not acceptable values")
        @ExceptionHandler(NullPointerException.class)
        public void nullPointerExceptionHandler(){}

}
