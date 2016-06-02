package com.wordflip.api.controllers;

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

    private static final String template = "Hello, %s!";
    private final AtomicLong counter = new AtomicLong();

    @RequestMapping("/login")
    public Pupil greeting(@RequestParam(value="name", defaultValue="World") String name, @RequestParam(value="password", defaultValue = "World") String password) {
        jt.getQueryTimeout();

        Pupil p = jt.queryForObject("SELECT * FROM LEERLING WHERE GEBRUIKERSNAAM = ? AND WACHTWOORD = ?", new Object[]{name, password}, new RowMapper<Pupil>() {
            @Override
            public Pupil mapRow(ResultSet resultSet, int i) throws SQLException {
                Calendar c = Calendar.getInstance();
                c.setTime(resultSet.getTimestamp("Laatstingelogd"));
                Pupil p = new Pupil(resultSet.getInt("ID"), resultSet.getString("Gebruikersnaam"), resultSet.getString("Wachtwoord"), c);
                return p;
            }
        });

        return p;
    }
}
