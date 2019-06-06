package com.bbdd.wms.services;

import com.bbdd.wms.exceptions.ElementAlreadyExistsException;
import com.bbdd.wms.models.Pallet;
import com.bbdd.wms.repos.*;
import com.bbdd.wms.repos.PalletDao;
import com.bbdd.wms.repos.PalletDao;
import com.bbdd.wms.repos.PalletDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import javax.persistence.EntityManager;
import java.util.List;

@Service
public class PalletService {

    @Autowired
    private PalletDao palletDao;

    public List<Pallet> findAll(){
        return palletDao.findAll();
    }

    public Pallet save(Pallet c){
        if(!palletDao.existsById(c.getCodPallet())){
            return palletDao.save(c);
        } else throw new ElementAlreadyExistsException();
    }

    public Pallet getOne(long id){
        if(palletDao.existsById(id)){
            return palletDao.findById(id).get();
        } else throw new IllegalArgumentException();

    }

    public Pallet update(Pallet c, long id){
        if (palletDao.existsById(id)) {
            c.setCodPallet(id);
            Pallet cl= palletDao.getOne(id);
            cl.setAll(c);
            return palletDao.save(cl);
        } else throw new IllegalArgumentException();
    }

    public void delete(long id){
        if(palletDao.existsById(id)){
            palletDao.deleteById(id);
        } else throw new IllegalArgumentException();
    }
}
