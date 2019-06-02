package com.bbdd.wms.controller;

import com.bbdd.wms.models.Cliente;
import com.bbdd.wms.services.ClienteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/cliente")
public class ClienteController {

    @Autowired
    private ClienteService clienteService;

    @GetMapping
    public List<Cliente> findAll(){
        return clienteService.findAll();
    }

    @PostMapping
    public Cliente post(@RequestBody Cliente cliente){
        return clienteService.save(cliente);
    }

    @GetMapping("/{id}")
    public Cliente getOne(@PathVariable (value = "id")  long id){
        return clienteService.getOne(id);
    }

    @PutMapping("/{id}")
    public Cliente update(Cliente c, @PathVariable (value = "id") long id){
        return clienteService.update(c,id);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable (value = "id") long id){
        clienteService.delete(id);
    }

}
