package com.wordflip.api.models;

import org.joda.time.DateTime;
import org.joda.time.Days;

import java.util.Calendar;

/**
 * Created by robvangastel on 02/06/16.
 */
public class Practice {

    private int duration;
    private int amountOfWords;
    private int mistakes;
    private Calendar timeOfPractice;

    public Practice(int duration, int amountOfWords, int mistakes) {
        this.duration = duration;
        this.amountOfWords = amountOfWords;
        this.mistakes = mistakes;
    }

    public Practice(int duration, int amountOfWords, int mistakes, Calendar timeOfPractice) {
        this.duration = duration;
        this.amountOfWords = amountOfWords;
        this.mistakes = mistakes;
        this.timeOfPractice = timeOfPractice;
    }

    public int getAmountOfWords() {
        return amountOfWords;
    }

    public int getDuration() {
        return duration;
    }

    public int getMistakes() {
        return mistakes;
    }

    public Calendar getTimeOfPractice() {
        return timeOfPractice;
    }

    public int compareDates(Practice o) {
        DateTime date = new DateTime(timeOfPractice.getTime());
        DateTime otherDate = new DateTime(o.getTimeOfPractice().getTime());
        return Days.daysBetween(date, otherDate).getDays();
    }

    public int compareSpeed() {
        int speed = duration/amountOfWords;

        if(speed < 20) {
            return -1;
        } else if(speed > 20 || speed < 40) {
            return 0;
        } else if(speed > 40) {
            return 1;
        }
        return 0;
    }

    public int compareCorrect() {
        double correct = mistakes/amountOfWords;

        if(correct < 0.3) {
            return -1;
        } else if(correct > 0.3 || correct < 0.7) {
            return 0;
        } else if(correct > 0.7) {
            return 1;
        }
        return 0;
    }
}
