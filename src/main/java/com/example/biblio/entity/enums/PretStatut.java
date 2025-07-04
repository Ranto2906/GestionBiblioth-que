package com.example.biblio.entity.enums;

public enum PretStatut {
    EN_COURS("en_cours"),
    RENDU("rendu"),
    EN_RETARD("en_retard"),
    PERDU("perdu");
    
    private final String value;
    
    PretStatut(String value) {
        this.value = value;
    }
    
    public String getValue() {
        return value;
    }
    
    public static PretStatut fromValue(String value) {
        for (PretStatut statut : values()) {
            if (statut.value.equals(value)) {
                return statut;
            }
        }
        throw new IllegalArgumentException("Valeur inconnue: " + value);
    }
} 