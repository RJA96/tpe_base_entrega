package com.bbdd.wms.controller;

import com.bbdd.wms.models.MovSalida;
import com.bbdd.wms.services.MovSalidaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/mov-salida")
public class MovSalidaController {

    @Autowired
    private MovSalidaService movSalidaService;

    @GetMapping
    public List<MovSalida> findAll(){
        return movSalidaService.findAll();
    }

    @PostMapping
    public MovSalida post(@RequestBody MovSalida MovSalida){
        return movSalidaService.save(MovSalida);
    }

    @GetMapping("/{id}")
    public MovSalida getOne(@PathVariable (value = "id")  long id){
        return movSalidaService.getOne(id);
    }

    @PutMapping("/{id}")
    public MovSalida update(@RequestBody MovSalida c, @PathVariable (value = "id") long id){
        return movSalidaService.update(c,id);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable (value = "id") long id){
        movSalidaService.delete(id);
    }

}
