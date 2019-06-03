package com.bbdd.wms.services;

import com.bbdd.wms.exceptions.ElementAlreadyExistsException;
import com.bbdd.wms.models.MovEntrada;
import com.bbdd.wms.repos.MovEntradaDao;
import com.bbdd.wms.repos.MovEntradaDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import javax.persistence.EntityManager;
import java.util.List;

@Service
public class MovEntradaService {

    @Autowired
    private MovEntradaDao movEntradaDao;

    public List<MovEntrada> findAll(){
        return movEntradaDao.findAll();
    }

    public MovEntrada save(MovEntrada c){
        if(!movEntradaDao.existsById(c.getIdMovimiento())){
            return movEntradaDao.save(c);
        } else throw new ElementAlreadyExistsException();
    }

    public MovEntrada getOne(long id){
        if(movEntradaDao.existsById(id)){
            return movEntradaDao.findById(id).get();
        } else throw new IllegalArgumentException();

    }

    public MovEntrada update(MovEntrada c, long id){
        if (movEntradaDao.existsById(id)) {
            c.setIdMovimiento(id);
            MovEntrada cl= movEntradaDao.getOne(id);
            cl.setAll(c);
            return movEntradaDao.save(cl);
        } else throw new IllegalArgumentException();
    }

    public void delete(long id){
        if(movEntradaDao.existsById(id)){
            movEntradaDao.deleteById(id);
        } else throw new IllegalArgumentException();
    }
}
