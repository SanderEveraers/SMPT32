package com.wordflip.api.controllers;

import com.wordflip.api.SqlCreator;
import com.wordflip.api.models.Pupil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.concurrent.atomic.AtomicLong;

/**
 * Created by fhict on 27-05-16.
 */

@RestController
public class PupilController {
    @Autowired
    private JdbcTemplate jt;

    private SqlCreator sqlCreator;

    @RequestMapping("/login")
    public Pupil greeting(@RequestParam(value="name", defaultValue="World") String name, @RequestParam(value="password", defaultValue = "World") String password) {
        jt.getQueryTimeout();

        sqlCreator = new SqlCreator();
        Pupil p = sqlCreator.loginPupil(name, password);


        return p;
    }
}
