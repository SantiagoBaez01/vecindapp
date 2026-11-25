package com.vecindapp.repository;

import com.vecindapp.entity.Rubro;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RubroRepository extends JpaRepository<Rubro, Integer> {
    Optional<Rubro> findByNombre(String nombre);
    boolean existsByNombre(String nombre);
}
