package com.bbdd.wms.repos;

import com.bbdd.wms.models.Estanteria;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EstanteriaDao extends JpaRepository<Estanteria,Long> {
}
