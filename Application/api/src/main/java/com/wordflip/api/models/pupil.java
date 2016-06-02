package com.wordflip.api.models;

import java.util.Calendar;

/**
 * Created by fhict on 27-05-16.
 */
public class Pupil {
    private int id;
    private String username;
    private String password;
    private Calendar lastLoggedIn;

    public Pupil(int id, String username, String password, Calendar lastLoggedIn) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.lastLoggedIn = lastLoggedIn;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Calendar getLastLoggedIn() {
        return lastLoggedIn;
    }

    public void setLastLoggedIn(Calendar lastLoggedIn) {
        this.lastLoggedIn = lastLoggedIn;
    }
}
