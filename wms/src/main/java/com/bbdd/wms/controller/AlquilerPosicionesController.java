package com.bbdd.wms.controller;

import com.bbdd.wms.models.Alquiler;
import com.bbdd.wms.models.AlquilerPosiciones;
import com.bbdd.wms.services.AlquilerPosicionesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/alquiler-posiciones")
public class AlquilerPosicionesController {

    @Autowired
    private AlquilerPosicionesService alquilerPosicionesService;

    @GetMapping
    public List<AlquilerPosiciones> findAll(){
        return alquilerPosicionesService.findAll();
    }

    @PostMapping
    public AlquilerPosiciones post(@RequestBody AlquilerPosiciones alquilerPosiciones){
        return alquilerPosicionesService.save(alquilerPosiciones);
    }

    @GetMapping("/{id}")
    public AlquilerPosiciones getOne(@PathVariable (value = "id")  long id){
        return alquilerPosicionesService.getOne(id);
    }

    @PutMapping("/{id}")
    public AlquilerPosiciones update(@RequestBody AlquilerPosiciones c, @PathVariable (value = "id") long id){
        return alquilerPosicionesService.update(c,id);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable (value = "id") long id){
        alquilerPosicionesService.delete(id);
    }

}
