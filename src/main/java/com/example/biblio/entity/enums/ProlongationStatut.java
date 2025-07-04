package com.example.biblio.entity.enums;

public enum ProlongationStatut {
    ACCEPTEE("acceptee"),
    REFUSEE("refusee"),
    EN_ATTENTE("en_attente");
    
    private final String value;
    
    ProlongationStatut(String value) {
        this.value = value;
    }
    
    public String getValue() {
        return value;
    }
    
    public static ProlongationStatut fromValue(String value) {
        for (ProlongationStatut statut : values()) {
            if (statut.value.equals(value)) {
                return statut;
            }
        }
        throw new IllegalArgumentException("Valeur inconnue: " + value);
    }
} 