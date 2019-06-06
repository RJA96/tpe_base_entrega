package com.bbdd.wms.controller;

import com.bbdd.wms.repos.PosicionDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("api/v1/ola")
public class PosicionController {

    @Autowired
    private PosicionDao posicionDao;

    @GetMapping
    public List<String> runIt(@RequestParam("date")
                                  @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Date date){
        return posicionDao.function(date);
    }
}
