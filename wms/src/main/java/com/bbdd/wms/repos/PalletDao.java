package com.bbdd.wms.repos;

import com.bbdd.wms.models.Pallet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PalletDao extends JpaRepository<Pallet,Long> {
}
