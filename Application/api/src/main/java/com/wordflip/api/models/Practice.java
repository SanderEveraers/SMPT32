package com.wordflip.api.models;

import org.joda.time.DateTime;
import org.joda.time.Days;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

/**
 * Created by robvangastel on 02/06/16.
 */
public class Practice {

    private int duration;
    private int amountOfWords;
    private int mistakes;
    private Calendar timeOfPractice;
    private boolean planned;

    public Practice(int duration, int amountOfWords, int mistakes, boolean planned) {
        this.duration = duration;
        this.amountOfWords = amountOfWords;
        this.mistakes = mistakes;
	    this.planned = planned;
    }

    public Practice(int duration, int amountOfWords, int mistakes, Calendar timeOfPractice, boolean planned) {
        this.duration = duration;
        this.amountOfWords = amountOfWords;
        this.mistakes = mistakes;
        this.timeOfPractice = timeOfPractice;
	    this.planned = planned;
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

    public int compareDayParts(Practice o) {
        DateTime date = new DateTime(timeOfPractice.getTime());
        DateTime otherDate = new DateTime(o.getTimeOfPractice().getTime());
        return Math.abs(date.getHourOfDay() - otherDate.getHourOfDay());
    }

	public int getHourOfDay() {
		DateTime date = new DateTime(timeOfPractice.getTime());
		return date.getHourOfDay();
	}

    public int compareSpeed() {
        int speed = duration/amountOfWords;

        if(speed < 7) {
            return -1;
        } else if(speed > 7 || speed < 15) {
            return 0;
        } else if(speed > 15) {
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

	public int compareCorrectToets() {
		double correct = mistakes/amountOfWords;

		if(correct < 0.3) {
			return 1;
		} else if(correct > 0.3 || correct < 0.5) {
			return 2;
		} else if(correct > 0.5 || correct < 0.7) {
			return 3;
		} else if(correct > 0.7) {
			return 4;
		}
		return 2;
	}


	public boolean isPlanned() {
		return planned;
	}

	public void setPlanned(boolean planned) {
		this.planned = planned;
	}
}
