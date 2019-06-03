package com.bbdd.wms.services;

import com.bbdd.wms.exceptions.ElementAlreadyExistsException;
import com.bbdd.wms.models.MovSalida;
import com.bbdd.wms.repos.*;
import com.bbdd.wms.repos.MovSalidaDao;
import com.bbdd.wms.repos.MovSalidaDao;
import com.bbdd.wms.repos.MovSalidaDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import javax.persistence.EntityManager;
import java.util.List;

@Service
public class MovSalidaService {

    @Autowired
    private MovSalidaDao movSalidaDao;

    public List<MovSalida> findAll(){
        return movSalidaDao.findAll();
    }

    public MovSalida save(MovSalida c){
        if(!movSalidaDao.existsById(c.getIdMovimiento())){
            return movSalidaDao.save(c);
        } else throw new ElementAlreadyExistsException();
    }

    public MovSalida getOne(long id){
        if(movSalidaDao.existsById(id)){
            return movSalidaDao.findById(id).get();
        } else throw new IllegalArgumentException();

    }

    public MovSalida update(MovSalida c, long id){
        if (movSalidaDao.existsById(id)) {
            c.setIdMovimiento(id);
            MovSalida cl= movSalidaDao.getOne(id);
            cl.setAll(c);
            return movSalidaDao.save(cl);
        } else throw new IllegalArgumentException();
    }

    public void delete(long id){
        if(movSalidaDao.existsById(id)){
            movSalidaDao.deleteById(id);
        } else throw new IllegalArgumentException();
    }
}
