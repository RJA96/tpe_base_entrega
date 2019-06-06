package com.bbdd.wms.controller;

import com.bbdd.wms.models.Posicion;
import com.bbdd.wms.services.PosicionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/posicion")
public class PosicionController {

    @Autowired
    private PosicionService posicionService;

    @GetMapping
    public List<Posicion> findAll(){
        return posicionService.findAll();
    }

    @PostMapping
    public Posicion post(@RequestBody Posicion Posicion){
        return posicionService.save(Posicion);
    }

    @GetMapping("/{id}")
    public Posicion getOne(@PathVariable (value = "id")  long id){
        return posicionService.getOne(id);
    }

    @PutMapping("/{id}")
    public Posicion update(@RequestBody Posicion c, @PathVariable (value = "id") long id){
        return posicionService.update(c,id);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable (value = "id") long id){
        posicionService.delete(id);
    }

    @GetMapping("/pos-libres")
    public List<Map<Object,Object>> getPosicionesLibres(@RequestParam (value = "date") Date date){
        return posicionService.getPosicionesLibres(date);
    }

    @GetMapping("/pos-ocupadas")
    public List<Map<Object,Object>> getPosicionesOcupadas(@RequestParam (value = "id") int id){
        return posicionService.getPosicionesOcupadas(id);
    }
}
