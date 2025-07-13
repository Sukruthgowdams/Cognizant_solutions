package com.example.springrest.controller;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class HelloWorldController {
    
    @GetMapping("/hello")
    public String sayHello() {
        return "Hello World from RESTful Web Service!";
    }
    
    @GetMapping("/hello/{name}")
    public String sayHelloWithName(@PathVariable String name) {
        return "Hello " + name + " from RESTful Web Service!";
    }
    
    @PostMapping("/hello")
    public String sayHelloPost(@RequestBody String name) {
        return "Hello " + name + " from POST request!";
    }
    
    @GetMapping("/hello/greeting")
    public HelloWorldResponse getGreeting() {
        return new HelloWorldResponse("Hello World!", "This is a RESTful response");
    }
    
    @GetMapping("/hello/greeting/{name}")
    public HelloWorldResponse getPersonalizedGreeting(@PathVariable String name) {
        return new HelloWorldResponse("Hello " + name + "!", "Welcome to our RESTful service");
    }
}

// Response class
class HelloWorldResponse {
    private String message;
    private String description;
    
    public HelloWorldResponse(String message, String description) {
        this.message = message;
        this.description = description;
    }
    
    // Getters and Setters
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}