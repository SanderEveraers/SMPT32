package com.wordflip.api.models;

/**
 * Created by robvangastel on 10/06/16.
 */
public class Subject {
	private String name;
	private int amount;

	public Subject(int amount, String name) {
		this.name = name;
		this.amount = amount;
	}

	public String getName() {
		return name;
	}

	public int getAmount() {
		return amount;
	}

	public void appendAmount(int amount) {
		this.amount += amount;
	}
}
