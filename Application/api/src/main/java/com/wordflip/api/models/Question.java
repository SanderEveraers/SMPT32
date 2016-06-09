package com.wordflip.api.models;

import java.io.Serializable;

/**
 * Created by bramd on 2-6-2016.
 */
public class Question implements Serializable {
    private int id;
    private int courseid;
    private String question;
    private String answer;
    private String sentence;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCourseid() {
        return courseid;
    }

    public void setCourseid(int courseid) {
        this.courseid = courseid;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public String getSentence() {
        return sentence;
    }

    public void setSentence(String sentence) {
        this.sentence = sentence;
    }

    public Question(int id, int courseid, String question, String answer, String sentence) {
        this.id = id;
        this.courseid = courseid;
        this.question = question;
        this.answer = answer;
        this.sentence = sentence;
    }
}

