package com.bbdd.wms.repos;

import com.bbdd.wms.models.Posicion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Repository
public interface PosicionDao extends JpaRepository<Posicion,Long> {
    @Query(value = "SELECT * FROM FN_GR05_pos_libres_fecha(:date)", nativeQuery = true)
    public List<Map<Object,Object>> getFechasLibres(
            @Param("date") Date date);

    @Query(value = "SELECT * FROM FN_GR05_pos_ocupadas_cliente(:id)", nativeQuery = true)
    public List<Map<Object,Object>> getFechasOcupadas(
            @Param("id") int id);
}
