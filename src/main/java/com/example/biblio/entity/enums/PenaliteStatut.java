package com.example.biblio.entity.enums;

public enum PenaliteStatut {
    IMPAYEE("impayee"),
    PAYEE("payee"),
    ANNULEE("annulee"),
    REMISE("remise");
    
    private final String value;
    
    PenaliteStatut(String value) {
        this.value = value;
    }
    
    public String getValue() {
        return value;
    }
    
    public static PenaliteStatut fromValue(String value) {
        for (PenaliteStatut statut : values()) {
            if (statut.value.equals(value)) {
                return statut;
            }
        }
        throw new IllegalArgumentException("Valeur inconnue: " + value);
    }
} 