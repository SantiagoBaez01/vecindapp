package com.vecindapp.repository;

import com.vecindapp.entity.Solicitud;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

public interface SolicitudRepository extends JpaRepository<Solicitud, Integer> {
    List<Solicitud> findByResidenteUsuarioIdOrderByIdDesc(Integer residenteId);
    List<Solicitud> findByPrestadorUsuarioIdOrderByIdDesc(Integer prestadorId);
}
