package com.vecindapp.repository;

import com.vecindapp.entity.Prestador;
import com.vecindapp.enums.EstadoPrestador;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PrestadorRepository extends JpaRepository<Prestador, Integer> {
    List<Prestador> findByEstadoVerificacion(EstadoPrestador estadoVerificacion);
}
