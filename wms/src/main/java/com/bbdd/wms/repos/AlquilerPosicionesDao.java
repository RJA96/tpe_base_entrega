package com.bbdd.wms.repos;

import com.bbdd.wms.models.AlquilerPosiciones;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AlquilerPosicionesDao extends JpaRepository<AlquilerPosiciones, Long> {
}
