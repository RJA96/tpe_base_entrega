package com.bbdd.wms.services;

import com.bbdd.wms.exceptions.ElementAlreadyExistsException;
import com.bbdd.wms.models.Estanteria;
import com.bbdd.wms.repos.EstanteriaDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import javax.persistence.EntityManager;
import java.util.List;

@Service
public class EstanteriaService {

    @Autowired
    private EstanteriaDao estanteriaDao;

    public List<Estanteria> findAll(){
        return estanteriaDao.findAll();
    }

    public Estanteria save(Estanteria c){
        if(estanteriaDao.existsById(c.getNroEstanteria())){
            return estanteriaDao.save(c);
        } else throw new ElementAlreadyExistsException();
    }

    public Estanteria getOne(long id){
        if(estanteriaDao.existsById(id)){
            return estanteriaDao.findById(id).get();
        } else throw new IllegalArgumentException();

    }

    public Estanteria update(Estanteria c, long id){
        if (estanteriaDao.existsById(id)) {
            c.setNroEstanteria(id);
            Estanteria cl= estanteriaDao.getOne(id);
            cl.setAll(c);
            return estanteriaDao.save(cl);
        } else throw new IllegalArgumentException();
    }

    public void delete(long id){
        if(estanteriaDao.existsById(id)){
            estanteriaDao.deleteById(id);
        } else throw new IllegalArgumentException();
    }
}
