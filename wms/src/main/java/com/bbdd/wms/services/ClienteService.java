package com.bbdd.wms.services;

import com.bbdd.wms.models.Cliente;
import com.bbdd.wms.repos.ClienteDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClienteService {

    @Autowired
    private ClienteDao clienteDao;

    public List<Cliente> findAll(){
        return clienteDao.findAll();
    }

    public Cliente save(Cliente c){
        return clienteDao.save(c);
    }

    public Cliente getOne(long id){
        if(clienteDao.existsById(id)){
            return clienteDao.findById(id).get();
        } else throw new IllegalArgumentException();

    }

    public Cliente update(Cliente c, long id){
        if (clienteDao.existsById(id)) {
            c.setCuitCuil(id);
            return clienteDao.save(c);
        } else throw new IllegalArgumentException();
    }

    public void delete(long id){
        if(clienteDao.existsById(id)){
            clienteDao.deleteById(id);
        } else throw new IllegalArgumentException();
    }
}
