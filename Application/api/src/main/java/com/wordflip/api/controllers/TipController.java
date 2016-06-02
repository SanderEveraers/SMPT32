package com.wordflip.api.controllers;

import com.mysql.jdbc.Statement;
import com.wordflip.api.DBConfiguration;
import com.wordflip.api.SqlCreator;
import com.wordflip.api.models.Greeting;
import com.wordflip.api.models.Practice;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.concurrent.atomic.AtomicLong;

/**
 * Created by robvangastel on 27/05/16.
 */

@RestController
@RequestMapping("/{userId}/tip")
public class TipController {

    @RequestMapping(method = RequestMethod.GET)
    public String tip(@PathVariable String userId) {

        SqlCreator creator = new SqlCreator();


        //jt.execute("SELECT * FROM LEERLING WHERE ID ='" + userId + "'");
        return "Blijf vooral leren";
    }

    @RequestMapping(method = RequestMethod.POST)
    public Practice add(@PathVariable String userId,
                      @RequestParam(value="amount", defaultValue="8") int amount,
                      @RequestParam(value="correct", defaultValue="0") int correct,
                      @RequestParam(value="date", defaultValue="12-12-1995") String date,
                      @RequestParam(value="duration", defaultValue="120") int duration) {
        System.out.println(amount);
        System.out.println(correct);
        System.out.println(date);
        System.out.println(duration);
        System.out.println(userId);

//        jt.execute("INSERT INTO oefenmoment(Tijdstip, Tijdsduur, Leerling_ID, aantal, correct) " +
//                "VALUES ('" + date + "','" + duration + "','" + userId + "','" + amount + "','" + duration + ")");

        return new Practice(Calendar.getInstance().getTime(), 10, 10);
//        return "Blijf vooral leren";
    }

    private void ValidateUser(String userId) {
//        jt.getQueryTimeout();
//        jt.execute("SELECT * FROM LEERLING WHERE ID ='" + userId + "'");
//        if(jt.getFetchSize() < 0) {
//            throw new UserNotFoundException(userId);
//        }
    }
}

@ResponseStatus(HttpStatus.NOT_FOUND)
class UserNotFoundException extends RuntimeException {

    public UserNotFoundException(String userId) {
        super("could not find user '" + userId + "'.");
    }
}
