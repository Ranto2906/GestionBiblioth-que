package com.example.biblio.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AccueilController {
    @GetMapping("/")
    public String accueil() {
        return "index"; // Affichera /WEB-INF/views/index.jsp
    }
}