package com.bbdd.wms.controller;

import com.bbdd.wms.models.Fila;
import com.bbdd.wms.services.FilaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/fila")
public class FilaController {

    @Autowired
    private FilaService filaService;

    @GetMapping
    public List<Fila> findAll(){
        return filaService.findAll();
    }

    @PostMapping
    public Fila post(@RequestBody Fila Fila){
        return filaService.save(Fila);
    }

    @GetMapping("/{id}")
    public Fila getOne(@PathVariable (value = "id")  long id){
        return filaService.getOne(id);
    }

    @PutMapping("/{id}")
    public Fila update(@RequestBody Fila c, @PathVariable (value = "id") long id){
        return filaService.update(c,id);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable (value = "id") long id){
        filaService.delete(id);
    }

}
