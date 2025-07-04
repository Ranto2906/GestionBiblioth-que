package com.example.biblio.entity.enums;

public enum NotificationStatut {
    EN_ATTENTE("en_attente"),
    ENVOYE("envoye"),
    LU("lu"),
    ECHEC("echec");
    
    private final String value;
    
    NotificationStatut(String value) {
        this.value = value;
    }
    
    public String getValue() {
        return value;
    }
    
    public static NotificationStatut fromValue(String value) {
        for (NotificationStatut statut : values()) {
            if (statut.value.equals(value)) {
                return statut;
            }
        }
        throw new IllegalArgumentException("Valeur inconnue: " + value);
    }
} 