# Diagrama de Clases (UML) - Vecindapp

Este diagrama representa el modelo de dominio orientado a objetos para el backend en Spring Boot.
A partir de acá se va a modificar y versionar, una vez completo se exporta a imagen o PDF.

```mermaid
classDiagram
    %% Clases principales (Entidades JPA)
    class Usuario {
        -Long id
        -String email
        -String password
        -String telefono
        -RolUsuario rol
        -LocalDateTime fechaAlta
        +login(String password) Boolean
    }

    class Residente {
        -String nombreCompleto
        -String lote
        -Boolean estado
        +solicitarServicio(Prestador p, String descripcion) Solicitud
        +dejarResena(Solicitud s, int puntos, String comentario) Resena
    }

    class Prestador {
        -String nombreCompleto
        -String descripcion
        -EstadoPrestador estadoVerificacion
        -List~Rubro~ rubros
        +agregarRubro(Rubro r)
        +presupuestar(Solicitud s)
    }

    class Rubro {
        -Long id
        -String nombre
    }

    class Solicitud {
        -Long id
        -Residente residente
        -Prestador prestador
        -String descripcionTarea
        -EstadoSolicitud estado
        -LocalDateTime fechaCreacion
        -LocalDateTime fechaActualizacion
        +avanzarEstado(EstadoSolicitud nuevoEstado)
    }

    class Resena {
        -Long id
        -Solicitud solicitud
        -Integer calificacion
        -String comentario
        -EstadoResena estado
        -LocalDateTime fechaCreacion
        +moderar(EstadoResena nuevoEstado)
    }

    %% Enumeraciones
    class RolUsuario {
        <<enumeration>>
        ADMIN
        RESIDENTE
        PRESTADOR
    }

    class EstadoPrestador {
        <<enumeration>>
        PENDIENTE
        HABILITADO
        RECHAZADO
    }

    class EstadoSolicitud {
        <<enumeration>>
        PENDIENTE
        PRESUPUESTADO
        ACEPTADO
        FINALIZADO
        CANCELADO
    }

    class EstadoResena {
        <<enumeration>>
        VISIBLE
        OCULTA
    }

    %% Relaciones Orientadas a Objetos
    Usuario <|-- Residente : hereda
    Usuario <|-- Prestador : hereda
    
    Prestador "*" --> "*" Rubro : ofrece (ManyToMany)
    
    Residente "1" --> "*" Solicitud : genera (OneToMany)
    Prestador "1" --> "*" Solicitud : recibe (OneToMany)
    
    Solicitud "1" --> "0..1" Resena : tiene (OneToOne)
```