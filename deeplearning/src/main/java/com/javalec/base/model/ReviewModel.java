package com.javalec.base.model;

import java.sql.Date;

public class ReviewModel {
	
	int reId;
	String reText;
	Date reInDate;
	Date reMoDate;
	Date reDelDate;
	int reStarRating;
	String to_userId;
	String from_userId1;
	
	public ReviewModel(int reId, String reText, Date reInDate, Date reMoDate, Date reDelDate, int reStarRating,
			String to_userId, String from_userId1) {
		super();
		this.reId = reId;
		this.reText = reText;
		this.reInDate = reInDate;
		this.reMoDate = reMoDate;
		this.reDelDate = reDelDate;
		this.reStarRating = reStarRating;
		this.to_userId = to_userId;
		this.from_userId1 = from_userId1;
	}

	public int getReId() {
		return reId;
	}

	public void setReId(int reId) {
		this.reId = reId;
	}

	public String getReText() {
		return reText;
	}

	public void setReText(String reText) {
		this.reText = reText;
	}

	public Date getReInDate() {
		return reInDate;
	}

	public void setReInDate(Date reInDate) {
		this.reInDate = reInDate;
	}

	public Date getReMoDate() {
		return reMoDate;
	}

	public void setReMoDate(Date reMoDate) {
		this.reMoDate = reMoDate;
	}

	public Date getReDelDate() {
		return reDelDate;
	}

	public void setReDelDate(Date reDelDate) {
		this.reDelDate = reDelDate;
	}

	public int getReStarRating() {
		return reStarRating;
	}

	public void setReStarRating(int reStarRating) {
		this.reStarRating = reStarRating;
	}

	public String getTo_userId() {
		return to_userId;
	}

	public void setTo_userId(String to_userId) {
		this.to_userId = to_userId;
	}

	public String getFrom_userId1() {
		return from_userId1;
	}

	public void setFrom_userId1(String from_userId1) {
		this.from_userId1 = from_userId1;
	}
	
	

}
