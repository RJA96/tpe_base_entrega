package com.bbdd.wms.services;

import com.bbdd.wms.exceptions.ElementAlreadyExistsException;
import com.bbdd.wms.models.Movimiento;
import com.bbdd.wms.repos.MovimientoDao;
import com.bbdd.wms.repos.MovimientoDao;
import com.bbdd.wms.repos.MovimientoDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import javax.persistence.EntityManager;
import java.util.List;

@Service
public class MovimientoService {

    @Autowired
    private MovimientoDao movimientoDao;

    public List<Movimiento> findAll(){
        return movimientoDao.findAll();
    }

    public Movimiento save(Movimiento c){
        if(!movimientoDao.existsById(c.getIdMovimiento())){
            return movimientoDao.save(c);
        } else throw new ElementAlreadyExistsException();
    }

    public Movimiento getOne(long id){
        if(movimientoDao.existsById(id)){
            return movimientoDao.findById(id).get();
        } else throw new IllegalArgumentException();

    }

    public Movimiento update(Movimiento c, long id){
        if (movimientoDao.existsById(id)) {
            c.setIdMovimiento(id);
            Movimiento cl= movimientoDao.getOne(id);
            cl.setAll(c);
            return movimientoDao.save(cl);
        } else throw new IllegalArgumentException();
    }

    public void delete(long id){
        if(movimientoDao.existsById(id)){
            movimientoDao.deleteById(id);
        } else throw new IllegalArgumentException();
    }
}
