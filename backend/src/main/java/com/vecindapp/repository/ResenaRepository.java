package com.vecindapp.repository;

import com.vecindapp.entity.Resena;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ResenaRepository extends JpaRepository<Resena, Integer> {
    boolean existsBySolicitudId(Integer solicitudId);
}
