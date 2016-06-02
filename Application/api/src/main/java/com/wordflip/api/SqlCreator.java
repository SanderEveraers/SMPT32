package com.wordflip.api;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.PreparedStatement;
import com.mysql.jdbc.Statement;
import com.wordflip.api.models.Practice;
import com.wordflip.api.models.Pupil;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.util.Calendar;

/**
 * Created by robvangastel on 02/06/16.
 */
public class SqlCreator {

    private DataSource ds;

    public SqlCreator() {
        try {
            DBConfiguration db = new DBConfiguration();
            ds = db.dataSource();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean testDataSource() {

        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        boolean gotConnection = false;

        try {
            con = (Connection) ds.getConnection();
            stmt = (Statement) con.createStatement();
            rs = stmt.executeQuery("select * FROM leerling");

            while(rs.next()){
                gotConnection = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            try {
                if(rs != null) rs.close();
                if(stmt != null) stmt.close();
                if(con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return gotConnection;
    }

    public boolean validateUser(String userId) {

        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        boolean valid = false;

        try {
            con = (Connection) ds.getConnection();
            stmt = (Statement) con.createStatement();
            rs = stmt.executeQuery("select * FROM leerling WHERE ID =" + userId);

            while(rs.next()){
                valid = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            try {
                if(rs != null) rs.close();
                if(stmt != null) stmt.close();
                if(con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return valid;
    }

    public Pupil loginPupil(String username, String password) {

        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Pupil p = null;

        try {
            con = (Connection) ds.getConnection();
            stmt = (PreparedStatement) con.prepareStatement("SELECT * FROM leerling WHERE gebruikersnaam = ? AND wachtwoord = ?");
            stmt.setString(1, username);
            stmt.setString(2, password);
            rs = stmt.executeQuery();

            while(rs.next()){
                Calendar c = Calendar.getInstance();
                c.setTime(rs.getTimestamp("Laatstingelogd"));
                p = new Pupil(rs.getInt("ID"), rs.getString("Gebruikersnaam"), rs.getString("Wachtwoord"), c);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            try {
                if(rs != null) rs.close();
                if(stmt != null) stmt.close();
                if(con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return p;
    }

    public void addPractice(Practice practice, String userId) {

        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            con = (Connection) ds.getConnection();
            stmt = (Statement) con.createStatement();

            stmt.execute("INSERT INTO oefenmoment(Tijdstip, Tijdsduur, Leerling_ID, Aantal, Correct) VALUES ( " +
                    "DATE_FORMAT(NOW(),'%m-%d-%Y %T:%S')"+ ",'" + practice.getDuration() + "','" + userId + "','" +
                    practice.getAmountOfWords() + "','" + practice.getCorrect() + "')");
        } catch (SQLException e) {
            e.printStackTrace();
        }finally{
            try {
                if(rs != null) rs.close();
                if(stmt != null) stmt.close();
                if(con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
