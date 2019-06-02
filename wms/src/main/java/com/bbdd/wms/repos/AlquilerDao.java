package com.bbdd.wms.repos;

import com.bbdd.wms.models.Alquiler;
import com.bbdd.wms.models.Cliente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestBody;

@Repository
public interface AlquilerDao extends JpaRepository<Alquiler,Long> {
}
