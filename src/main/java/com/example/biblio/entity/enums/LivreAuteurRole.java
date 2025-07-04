package com.example.biblio.entity.enums;

public enum LivreAuteurRole {
    AUTEUR_PRINCIPAL("auteur_principal"),
    CO_AUTEUR("co_auteur"),
    TRADUCTEUR("traducteur"),
    ILLUSTRATEUR("illustrateur"),
    EDITEUR_SCIENTIFIQUE("editeur_scientifique");
    
    private final String value;
    
    LivreAuteurRole(String value) {
        this.value = value;
    }
    
    public String getValue() {
        return value;
    }
    
    public static LivreAuteurRole fromValue(String value) {
        for (LivreAuteurRole role : values()) {
            if (role.value.equals(value)) {
                return role;
            }
        }
        throw new IllegalArgumentException("Valeur inconnue: " + value);
    }
} 