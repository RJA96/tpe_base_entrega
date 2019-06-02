package com.bbdd.wms.repos;

import com.bbdd.wms.models.Cliente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ClienteDao extends JpaRepository <Cliente, Long> {
}
