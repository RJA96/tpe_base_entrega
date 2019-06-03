package com.bbdd.wms.controller;

import com.bbdd.wms.models.Estanteria;
import com.bbdd.wms.services.EstanteriaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/estanteria")
public class EstanteriaController {

    @Autowired
    private EstanteriaService estanteriaService;

    @GetMapping
    public List<Estanteria> findAll(){
        return estanteriaService.findAll();
    }

    @PostMapping
    public Estanteria post(@RequestBody Estanteria Estanteria){
        return estanteriaService.save(Estanteria);
    }

    @GetMapping("/{id}")
    public Estanteria getOne(@PathVariable (value = "id")  long id){
        return estanteriaService.getOne(id);
    }

    @PutMapping("/{id}")
    public Estanteria update(@RequestBody Estanteria c, @PathVariable (value = "id") long id){
        return estanteriaService.update(c,id);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable (value = "id") long id){
        estanteriaService.delete(id);
    }

}
