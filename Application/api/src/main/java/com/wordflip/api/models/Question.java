package com.wordflip.api.models;

/**
 * Created by bramd on 2-6-2016.
 */
public class Question {
    private int id;
    private String quenstion;
    private String answer;
    private String sentence;

    public Question(int id, String quenstion, String answer, String sentence) {
        this.id = id;
        this.quenstion = quenstion;
        this.answer = answer;
        this.sentence = sentence;
    }
}
