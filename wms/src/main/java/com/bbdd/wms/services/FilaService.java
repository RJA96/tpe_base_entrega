package com.bbdd.wms.services;

import com.bbdd.wms.exceptions.ElementAlreadyExistsException;
import com.bbdd.wms.models.Fila;
import com.bbdd.wms.repos.FilaDao;
import com.bbdd.wms.repos.FilaDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import javax.persistence.EntityManager;
import java.util.List;

@Service
public class FilaService {

    @Autowired
    private FilaDao filaDao;

    public List<Fila> findAll(){
        return filaDao.findAll();
    }

    public Fila save(Fila c){
        if(!filaDao.existsById(c.getNroFila())){
            return filaDao.save(c);
        } else throw new ElementAlreadyExistsException();
    }

    public Fila getOne(long id){
        if(filaDao.existsById(id)){
            return filaDao.findById(id).get();
        } else throw new IllegalArgumentException();

    }

    public Fila update(Fila c, long id){
        if (filaDao.existsById(id)) {
            c.setNroFila(id);
            Fila cl= filaDao.getOne(id);
            cl.setAll(c);
            return filaDao.save(cl);
        } else throw new IllegalArgumentException();
    }

    public void delete(long id){
        if(filaDao.existsById(id)){
            filaDao.deleteById(id);
        } else throw new IllegalArgumentException();
    }
}
