package com.bbdd.wms.repos;

import com.bbdd.wms.models.Movimiento;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MovimientoDao extends JpaRepository<Movimiento,Long> {
}
