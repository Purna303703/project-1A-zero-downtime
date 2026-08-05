package com.zetheta.zero_downtime_app;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/")
    public String home() {
        return "Project 1A - Zero Downtime CI/CD Pipeline is Running!";
    }

    @GetMapping("/version")
    public String version() {
        return "Version 1.0";
    }
}