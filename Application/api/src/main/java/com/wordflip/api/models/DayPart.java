package com.wordflip.api.models;

/**
 * Created by robvangastel on 09/06/16.
 */
public class DayPart {

	private int amount;
	private String name;

	public DayPart(int amount, String name) {
		this.amount = amount;
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public void appendAmount(int amount) {
		this.amount += amount;
	}
}
