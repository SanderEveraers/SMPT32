/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.wordflip.api.controllers;

import com.wordflip.api.models.Greeting;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.concurrent.atomic.AtomicLong;
/**
 *
 * @author robvangastel
 */


@RestController
public class GreetingController {

    @Autowired
    private JdbcTemplate jt;

    private static final String template = "Hello, %s!";
    private final AtomicLong counter = new AtomicLong();

    @RequestMapping("/greeting")
    public Greeting greeting(@RequestParam(value="name", defaultValue="World") String name) {
        jt.getQueryTimeout();
        jt.execute("SELECT * FROM LEERLING");
        return new Greeting(counter.incrementAndGet(),
                            String.format(template, name));
    }
}