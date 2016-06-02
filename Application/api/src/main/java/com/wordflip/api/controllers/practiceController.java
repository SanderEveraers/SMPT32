package com.wordflip.api.controllers;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;
import com.wordflip.api.SqlCreator;
import com.wordflip.api.models.Question;
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.*;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * Created by bramiscool on 02/06/16.
 */

@RestController
@RequestMapping("/practice")
public class PracticeController {
    private SqlCreator sqlCreator;
    private DataSource ds;

    @RequestMapping(value = "/practice", method = RequestMethod.GET)
    public ArrayList tip(@RequestParam(value="course", defaultValue="Engels") String course, @RequestParam(value="userid", defaultValue="0") String userID) {
        ds = sqlCreator.createDataSource();
        Connection con = null;
        ResultSet rs = null;
        Statement stmt = null;
        ArrayList<Question> questions = new ArrayList<>();
        try {
            con = (Connection) ds.getConnection();
            stmt = (Statement) con.createStatement();
            rs = stmt.executeQuery("CALL `getToetsvragen`('" + course + "', " + userID + ")");
            while(rs.next()){
                Question q = new Question(rs.getInt("ID"), rs.getString("Vraag"), rs.getString("Antwoord"), rs.getString("ContextZin"));
                questions.add(q);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            try {
                if(rs != null) rs.close();
                if(stmt != null) stmt.close();
                if(con != null) con.close();
                return questions;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }
}
