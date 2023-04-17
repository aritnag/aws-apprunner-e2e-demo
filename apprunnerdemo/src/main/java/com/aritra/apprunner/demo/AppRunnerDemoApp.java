package com.aritra.apprunner.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan({"com.aritra.apprunner.demo"})
public class AppRunnerDemoApp {
    public static void main(String[] args) {
        SpringApplication.run(AppRunnerDemoApp.class, args);
    }
}
