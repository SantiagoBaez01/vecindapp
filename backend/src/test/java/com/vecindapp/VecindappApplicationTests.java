package com.vecindapp;

import com.vecindapp.enums.EstadoSolicitud;
import com.vecindapp.enums.RolUsuario;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

/**
 * Smoke sin levantar el contexto Spring (requiere MySQL).
 * La validación JPA contra el esquema se hace arrancando la app con perfil local.
 */
class VecindappApplicationTests {

    @Test
    void enumsDelDominio() {
        assertEquals("ADMIN", RolUsuario.ADMIN.name());
        assertEquals("FINALIZADO", EstadoSolicitud.FINALIZADO.name());
    }
}
