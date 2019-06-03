package com.bbdd.wms.services;

import com.bbdd.wms.exceptions.ElementAlreadyExistsException;
import com.bbdd.wms.models.MovInterno;
import com.bbdd.wms.repos.MovInternoDao;
import com.bbdd.wms.repos.MovInternoDao;
import com.bbdd.wms.repos.MovInternoDao;
import com.bbdd.wms.repos.MovInternoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import javax.persistence.EntityManager;
import java.util.List;

@Service
public class MovInternoService {

    @Autowired
    private MovInternoDao movInternoDao;

    public List<MovInterno> findAll(){
        return movInternoDao.findAll();
    }

    public MovInterno save(MovInterno c){
        if(movInternoDao.existsById(c.getIdMovimiento())){
            return movInternoDao.save(c);
        } else throw new ElementAlreadyExistsException();
    }

    public MovInterno getOne(long id){
        if(movInternoDao.existsById(id)){
            return movInternoDao.findById(id).get();
        } else throw new IllegalArgumentException();

    }

    public MovInterno update(MovInterno c, long id){
        if (movInternoDao.existsById(id)) {
            c.setIdMovimiento(id);
            MovInterno cl= movInternoDao.getOne(id);
            cl.setAll(c);
            return movInternoDao.save(cl);
        } else throw new IllegalArgumentException();
    }

    public void delete(long id){
        if(movInternoDao.existsById(id)){
            movInternoDao.deleteById(id);
        } else throw new IllegalArgumentException();
    }
}
