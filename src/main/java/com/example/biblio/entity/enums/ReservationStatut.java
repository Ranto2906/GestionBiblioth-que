package com.example.biblio.entity.enums;

public enum ReservationStatut {
    EN_ATTENTE("en_attente"),
    NOTIFIE("notifie"),
    SATISFAITE("satisfaite"),
    ANNULEE("annulee"),
    EXPIREE("expiree");
    
    private final String value;
    
    ReservationStatut(String value) {
        this.value = value;
    }
    
    public String getValue() {
        return value;
    }
    
    public static ReservationStatut fromValue(String value) {
        for (ReservationStatut statut : values()) {
            if (statut.value.equals(value)) {
                return statut;
            }
        }
        throw new IllegalArgumentException("Valeur inconnue: " + value);
    }
} 