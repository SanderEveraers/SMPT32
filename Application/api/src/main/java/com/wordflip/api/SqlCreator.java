package com.wordflip.api;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;
import com.wordflip.api.models.Practice;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;

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

    public DataSource createDataSource(){
        try {
            DBConfiguration db = new DBConfiguration();
            ds = db.dataSource();
            return ds;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
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

    public void addPractice(Practice practice, String userId) {

        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            con = (Connection) ds.getConnection();
            stmt = (Statement) con.createStatement();
            //java.sql.Date sqlDate = new java.sql.Date(practice.getDate().getTime());
            //System.out.println(sqlDate.toString());

            stmt.execute("INSERT INTO oefenmoment(Tijdstip, Tijdsduur, Leerling_ID, Aantal, Correct) VALUES ( " +
                    "T'" + practice.getDuration() + "','" + userId + "','" +
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
