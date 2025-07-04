package com.example.biblio.entity.enums;

public enum NotificationType {
    RESERVATION_DISPONIBLE("reservation_disponible"),
    RETOUR_IMMINENT("retour_imminent"),
    RETARD("retard"),
    PENALITE("penalite"),
    NOUVEAUTE("nouveaute");
    
    private final String value;
    
    NotificationType(String value) {
        this.value = value;
    }
    
    public String getValue() {
        return value;
    }
    
    public static NotificationType fromValue(String value) {
        for (NotificationType type : values()) {
            if (type.value.equals(value)) {
                return type;
            }
        }
        throw new IllegalArgumentException("Valeur inconnue: " + value);
    }
} 