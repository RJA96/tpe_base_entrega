package com.bbdd.wms.controller;

import com.bbdd.wms.models.MovEntrada;
import com.bbdd.wms.services.MovEntradaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/mov-entrada")
public class MovEntradaController {

    @Autowired
    private MovEntradaService movEntradaService;

    @GetMapping
    public List<MovEntrada> findAll(){
        return movEntradaService.findAll();
    }

    @PostMapping
    public MovEntrada post(@RequestBody MovEntrada MovEntrada){
        return movEntradaService.save(MovEntrada);
    }

    @GetMapping("/{id}")
    public MovEntrada getOne(@PathVariable (value = "id")  long id){
        return movEntradaService.getOne(id);
    }

    @PutMapping("/{id}")
    public MovEntrada update(@RequestBody MovEntrada c, @PathVariable (value = "id") long id){
        return movEntradaService.update(c,id);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable (value = "id") long id){
        movEntradaService.delete(id);
    }

}
