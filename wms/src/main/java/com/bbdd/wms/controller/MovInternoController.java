package com.bbdd.wms.controller;

import com.bbdd.wms.models.MovInterno;
import com.bbdd.wms.services.MovInternoService;
import com.bbdd.wms.services.MovInternoService;
import com.bbdd.wms.services.MovInternoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/mov-interno")
public class MovInternoController {

    @Autowired
    private MovInternoService movInternoService;

    @GetMapping
    public List<MovInterno> findAll(){
        return movInternoService.findAll();
    }

    @PostMapping
    public MovInterno post(@RequestBody MovInterno MovInterno){
        return movInternoService.save(MovInterno);
    }

    @GetMapping("/{id}")
    public MovInterno getOne(@PathVariable (value = "id")  long id){
        return movInternoService.getOne(id);
    }

    @PutMapping("/{id}")
    public MovInterno update(@RequestBody MovInterno c, @PathVariable (value = "id") long id){
        return movInternoService.update(c,id);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable (value = "id") long id){
        movInternoService.delete(id);
    }

}
