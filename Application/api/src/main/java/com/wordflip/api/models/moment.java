package com.wordflip.api.models;

/**
 * Created by robvangastel on 10/06/16.
 */
public class Moment {

	private int amount;
	private int planned;

	public Moment(int amount, int planned) {
		this.amount = amount;
		this.planned = planned;
	}

	public int getAmount() {
		return amount;
	}

	public int getPlanned() {
		return planned;
	}

	public void appendPlanned(int planned) {
		this.planned += planned;
	}
}
