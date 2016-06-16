package com.wordflip.api.models;

/**
 * Created by robvangastel on 10/06/16.
 */
public class Toets {

	private String name;
	private int rating;

	public Toets(String name, int rating) {
		this.name = name;
		this.rating = rating;
	}

	public String getName() {
		return name;
	}

	public int getRating() {
		return rating;
	}

	public void setRating(int rating) {
		this.rating = rating;
	}
}
