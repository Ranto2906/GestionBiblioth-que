package com.example.biblio.entity.enums;

public enum UtilisateurRole {
    ADMIN("admin"),
    BIBLIOTHECAIRE("bibliothecaire"),
    RESPONSABLE("responsable"),
    ADHERENT("adherent");
    
    private final String value;
    
    UtilisateurRole(String value) {
        this.value = value;
    }
    
    public String getValue() {
        return value;
    }
    
    public static UtilisateurRole fromValue(String value) {
        for (UtilisateurRole role : values()) {
            if (role.value.equals(value)) {
                return role;
            }
        }
        throw new IllegalArgumentException("Valeur inconnue: " + value);
    }
} 