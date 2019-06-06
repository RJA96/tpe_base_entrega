package com.bbdd.wms.services;

import com.bbdd.wms.exceptions.ElementAlreadyExistsException;
import com.bbdd.wms.models.Posicion;
import com.bbdd.wms.repos.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import javax.persistence.EntityManager;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service
public class PosicionService {

    @Autowired
    private PosicionDao posicionDao;

    public List<Posicion> findAll(){
        return posicionDao.findAll();
    }

    public Posicion save(Posicion c){
        if(!posicionDao.existsById(c.getNroEstanteria())){
            return posicionDao.save(c);
        } else throw new ElementAlreadyExistsException();
    }

    public Posicion getOne(long id){
        if(posicionDao.existsById(id)){
            return posicionDao.findById(id).get();
        } else throw new IllegalArgumentException();

    }

    public Posicion update(Posicion c, long id){
        if (posicionDao.existsById(id)) {
            c.setNroPosicion(id);
            Posicion cl= posicionDao.getOne(id);
            cl.setAll(c);
            return posicionDao.save(cl);
        } else throw new IllegalArgumentException();
    }

    public void delete(long id){
        if(posicionDao.existsById(id)){
            posicionDao.deleteById(id);
        } else throw new IllegalArgumentException();
    }

    public List<Map<Object, Object>> getPosicionesLibres(Date e) {
        return posicionDao.getFechasLibres(e);
    }
    public List<Map<Object, Object>> getPosicionesOcupadas(int e) {
        return posicionDao.getFechasOcupadas(e);
    }

}
