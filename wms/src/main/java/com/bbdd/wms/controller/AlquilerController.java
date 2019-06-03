package com.bbdd.wms.controller;

import com.bbdd.wms.models.Alquiler;
import com.bbdd.wms.services.AlquilerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/alquiler")
public class AlquilerController {

    @Autowired
    private AlquilerService alquilerService;

    @GetMapping
    public List<Alquiler> findAll(){
        return alquilerService.findAll();
    }

    @PostMapping
    public Alquiler post(@RequestBody Alquiler Alquiler){
        return alquilerService.save(Alquiler);
    }

    @GetMapping("/{id}")
    public Alquiler getOne(@PathVariable (value = "id")  long id){
        return alquilerService.getOne(id);
    }

    @PutMapping("/{id}")
    public Alquiler update(@RequestBody Alquiler c, @PathVariable (value = "id") long id){
        return alquilerService.update(c,id);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable (value = "id") long id){
        alquilerService.delete(id);
    }

}
