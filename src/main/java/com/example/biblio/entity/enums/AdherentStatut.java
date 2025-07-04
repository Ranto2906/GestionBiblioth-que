package com.example.biblio.entity.enums;

public enum AdherentStatut {
    ACTIF("actif"),
    SUSPENDU("suspendu"),
    EXPIRE("expire"),
    RADIE("radie"),
    EN_ATTENTE("en_attente");
    
    private final String value;
    
    AdherentStatut(String value) {
        this.value = value;
    }
    
    public String getValue() {
        return value;
    }
    
    public static AdherentStatut fromValue(String value) {
        for (AdherentStatut statut : values()) {
            if (statut.value.equals(value)) {
                return statut;
            }
        }
        throw new IllegalArgumentException("Valeur inconnue: " + value);
    }
} 