package com.wordflip.api.models;

import java.util.Date;

/**
 * Created by robvangastel on 02/06/16.
 */
public class Practice {

    private String date;
    private int duration;
    private int amountOfWords;
    private int correct;

    public Practice(String date, int duration, int amountOfWords, int correct) {
        this.date = date;
        this.duration = duration;
        this.amountOfWords = amountOfWords;
        this.correct = correct;
    }

    public int getAmountOfWords() {
        return amountOfWords;
    }

    public int getDuration() {
        return duration;
    }

    public String getDate() {
        return date;
    }

    public int getCorrect() {
        return correct;
    }
}
