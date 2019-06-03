package com.bbdd.wms.controller;

import com.bbdd.wms.models.Movimiento;
import com.bbdd.wms.services.MovimientoService;
import com.bbdd.wms.services.MovimientoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/movimiento")
public class MovimientoController {

    @Autowired
    private MovimientoService movimientoService;

    @GetMapping
    public List<Movimiento> findAll(){
        return movimientoService.findAll();
    }

    @PostMapping
    public Movimiento post(@RequestBody Movimiento Movimiento){
        return movimientoService.save(Movimiento);
    }

    @GetMapping("/{id}")
    public Movimiento getOne(@PathVariable (value = "id")  long id){
        return movimientoService.getOne(id);
    }

    @PutMapping("/{id}")
    public Movimiento update(@RequestBody Movimiento c, @PathVariable (value = "id") long id){
        return movimientoService.update(c,id);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable (value = "id") long id){
        movimientoService.delete(id);
    }

}
