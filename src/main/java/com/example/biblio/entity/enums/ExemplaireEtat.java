package com.example.biblio.entity.enums;

public enum ExemplaireEtat {
    NEUF("neuf"),
    BON("bon"),
    MOYEN("moyen"),
    ABIME("abime"),
    EN_REPARATION("en_reparation"),
    RETIRE("retire"),
    PERDU("perdu");
    
    private final String value;
    
    ExemplaireEtat(String value) {
        this.value = value;
    }
    
    public String getValue() {
        return value;
    }
    
    public static ExemplaireEtat fromValue(String value) {
        for (ExemplaireEtat etat : values()) {
            if (etat.value.equals(value)) {
                return etat;
            }
        }
        throw new IllegalArgumentException("Valeur inconnue: " + value);
    }
} 