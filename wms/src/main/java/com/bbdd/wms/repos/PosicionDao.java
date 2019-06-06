package com.bbdd.wms.repos;

import com.bbdd.wms.models.Posicion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Date;
import java.util.List;

public interface PosicionDao extends JpaRepository<Posicion,Long> {

    @Query(value = "SELECT * FROM FN_GR05_pos_libres_fecha('2018-07-05')", nativeQuery = true)
    public List<String> function(
            @Param("date") Date date);
}
