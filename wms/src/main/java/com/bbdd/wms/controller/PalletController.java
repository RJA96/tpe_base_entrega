package com.bbdd.wms.controller;

import com.bbdd.wms.models.Pallet;
import com.bbdd.wms.services.PalletService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/v1/pallet")
public class PalletController {

    @Autowired
    private PalletService palletService;

    @GetMapping
    public List<Pallet> findAll() {
        return palletService.findAll();
    }

    @PostMapping
    public Pallet post(@RequestBody Pallet Pallet){
        return palletService.save(Pallet);
    }

    @GetMapping("/{id}")
    public Pallet getOne(@PathVariable (value = "id")  long id){
        return palletService.getOne(id);
    }

    @PutMapping("/{id}")
    public Pallet update(@RequestBody Pallet c, @PathVariable (value = "id") long id){
        return palletService.update(c,id);
    }

    @DeleteMapping("/{id}")
    public void delete(@PathVariable (value = "id") long id){
        palletService.delete(id);
    }
}
