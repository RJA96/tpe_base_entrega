package com.bbdd.wms.services;

import com.bbdd.wms.exceptions.ElementAlreadyExistsException;
import com.bbdd.wms.models.Alquiler;
import com.bbdd.wms.repos.AlquilerDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AlquilerService {

    @Autowired
    private AlquilerDao alquilerDao;

    public List<Alquiler> findAll(){
        return alquilerDao.findAll();
    }

    public Alquiler save(Alquiler c){
        if(alquilerDao.existsById(c.getIdAlquiler())){
            return alquilerDao.save(c);
        } else throw new ElementAlreadyExistsException();
    }

    public Alquiler getOne(long id){
        if(alquilerDao.existsById(id)){
            return alquilerDao.findById(id).get();
        } else throw new IllegalArgumentException();
    }

    public Alquiler update(Alquiler c, long id){
        if (alquilerDao.existsById(id)) {
            c.setIdAlquiler(id);
            Alquiler al =alquilerDao.getOne(id);
            al.setAll(c);
            return alquilerDao.save(al);
        } else throw new IllegalArgumentException();
    }

    public void delete(long id){
        if(alquilerDao.existsById(id)){
            alquilerDao.deleteById(id);
        } else throw new IllegalArgumentException();
    }
}
