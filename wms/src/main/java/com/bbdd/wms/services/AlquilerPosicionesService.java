package com.bbdd.wms.services;

import com.bbdd.wms.exceptions.ElementAlreadyExistsException;
import com.bbdd.wms.models.Alquiler;
import com.bbdd.wms.models.AlquilerPosiciones;
import com.bbdd.wms.repos.AlquilerPosicionesDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AlquilerPosicionesService {

    @Autowired
    private AlquilerPosicionesDao alquilerPosicionesDao;

    public List<AlquilerPosiciones> findAll(){
        return alquilerPosicionesDao.findAll();
    }

    public AlquilerPosiciones save(AlquilerPosiciones c) {
        if(alquilerPosicionesDao.existsById(c.getIdAlquiler())){
            return alquilerPosicionesDao.save(c);
        } else throw new ElementAlreadyExistsException();
    }

    public AlquilerPosiciones getOne(long id){
        if(alquilerPosicionesDao.existsById(id)){
            return alquilerPosicionesDao.findById(id).get();
        } else throw new IllegalArgumentException();
    }

    public AlquilerPosiciones update(AlquilerPosiciones c, long id){
        if (alquilerPosicionesDao.existsById(id)) {
            c.setIdAlquiler(id);
            AlquilerPosiciones al =alquilerPosicionesDao.getOne(id);
            al.setAll(c);
            return alquilerPosicionesDao.save(al);
        } else throw new IllegalArgumentException();
    }

    public void delete(long id){
        if(alquilerPosicionesDao.existsById(id)){
            alquilerPosicionesDao.deleteById(id);
        } else throw new IllegalArgumentException();
    }
}