package com.wordflip.api.models;

import java.util.Date;

/**
 * Created by robvangastel on 02/06/16.
 */
public class Practice {

    private Date date;
    private int duration;
    private int amountOfWords;

    public Practice(Date date, int duration, int amountOfWords) {
        this.date = date;
        this.duration = duration;
        this.amountOfWords = amountOfWords;
    }

    public int getAmountOfWords() {
        return amountOfWords;
    }


    public int getDuration() {
        return duration;
    }

    public Date getDate() {
        return date;
    }
}
