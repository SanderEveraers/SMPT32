package com.wordflip.api.controllers;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;
import com.wordflip.api.SqlCreator;
import com.wordflip.api.models.Practice;
import com.wordflip.api.models.Question;
import javax.sql.DataSource;

import com.wordflip.api.models.Toets;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by bramiscool on 02/06/16.
 */

@RestController
//@RequestMapping("/practice")
public class PracticeController {
    private SqlCreator sqlCreator = new SqlCreator();
    private DataSource ds;

    @RequestMapping(value = "/practice", method = RequestMethod.GET) //http://localhost:8080/practice?userid=6&course=Engels
    public ResponseEntity<ArrayList<Question>> tip(@RequestParam(value="course", defaultValue="Engels") String course,
                                                   @RequestParam(value="userid", defaultValue="0") String userID) {
        ds = sqlCreator.createDataSource();
        Connection con = null;
        ResultSet rs = null;
        Statement stmt = null;
        ArrayList<Question> questions = new ArrayList<>();
        ArrayList<Practice> practices = new ArrayList<>();
        try {
            con = (Connection) ds.getConnection();
            stmt = (Statement) con.createStatement();
            int toetsID = 0;
            int aantalWoorden = 7;
            int speed = 0;
            int correctie = 0;

            rs = stmt.executeQuery("CALL `getOefenmomenten`(" + userID + ", '" + course + "')");
            while(rs.next()){
                Practice p = new Practice(rs.getInt("Tijdsduur"), rs.getInt("aantal"), rs.getInt("fouten"), true);
                practices.add(p);
            }
            if (practices.size() >= 2){
                for(int i = 0; i < practices.size(); i++) {
                    speed += practices.get(i).compareSpeed();
                    correctie += practices.get(i).compareCorrect();
                }

                correctie = correctie / practices.size();
                speed = speed / practices.size();

                if (speed < 0 || correctie < 0) { //SNEL EN WEINIG FOUTEN
                    aantalWoorden +=2;
                }

                if (speed > 0 || correctie > 0) { //TRAAG EN VEEL FOUTEN
                    aantalWoorden -=2;
                }

                if (speed < 0 || correctie > 0) { //SNEL MAAR VEEL FOUTEN
                    //aantalWoorden -=2;
                }
            }

            rs = stmt.executeQuery("CALL `getToetsvragen`('" + course + "', " + userID + ")");
            while(rs.next()){
                Question q = new Question(rs.getInt("ID"), rs.getInt("Toets_ID"), rs.getString("Vraag"), rs.getString("Antwoord"), rs.getString("ContextZin"));
                toetsID = rs.getInt("Toets_ID");
                questions.add(q);
            }

            rs = stmt.executeQuery("CALL `getLastProgress`('" + userID + "', " + toetsID + ")");
            int lastProgress = 0;
            while(rs.next()){
                lastProgress = rs.getInt("Aantal");
            }

            //System.out.println(toetsID);

            if ((lastProgress + aantalWoorden) > questions.size()){
                int wordsInPart1 = questions.size() - lastProgress;
                int wordsInPart2 = aantalWoorden - wordsInPart1;
                List part1 = questions.subList(lastProgress, questions.size());
                List part2 = questions.subList(0, wordsInPart2);
                questions = new ArrayList<>(part1);
                questions.addAll(part2);
            }else{
                questions = new ArrayList<>(questions.subList(lastProgress, lastProgress + aantalWoorden));
            }
            //System.out.println(toetsID);
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            try {
                if(rs != null) rs.close();
                if(stmt != null) stmt.close();
                if(con != null) con.close();
                return new ResponseEntity<>(questions, HttpStatus.OK);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    @RequestMapping(value = "/toetsrating", method = RequestMethod.GET) //http://localhost:8080/toetsrating?toetsid=1
    public ResponseEntity<Toets> toetslevel(@RequestParam(value="toetsid", defaultValue="0") int toetsID) {
        ds = sqlCreator.createDataSource();
        Connection con = null;
        ResultSet rs = null;
        PreparedStatement stmt = null;
        ArrayList<Practice> practices = new ArrayList<>();
        Toets toets = new Toets("Engels", 0);
        try {
            con = (Connection) ds.getConnection();

            stmt = (PreparedStatement) con.prepareStatement("SELECT * FROM oefenmoment o, klas k, toets t WHERE k.ID = t.Klas_ID AND o.toets_ID = t.ID AND t.ID = ?");
            stmt.setInt(1, toetsID);
            rs = stmt.executeQuery();

            while(rs.next()){
                Practice p = new Practice(rs.getInt("Tijdsduur"), rs.getInt("aantal"), rs.getInt("fouten"), true);
                practices.add(p);
            }

            int correctie = 0;
            if (practices.size() >= 2){
                for(int i = 0; i < practices.size(); i++) {
                    correctie += practices.get(i).compareCorrectToets();
                }

                correctie = correctie / practices.size();

                toets.setRating(correctie);

            }
            System.out.println(correctie);
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            try {
                if(rs != null) rs.close();
                if(stmt != null) stmt.close();
                if(con != null) con.close();
                return new ResponseEntity<>(toets, HttpStatus.OK);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return null;
    }


}
