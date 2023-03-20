package com.javalec.base.model;

import java.sql.Date;

public class Join_UserReviewModel{
	String reId;
	String reText;
	int reStarRating;
	String to_userId;
	String from_userId1;
	
	String userName;
	String userPw;
	String userAddress;
	int userReliability;
	Date reInDate;
	
	public Join_UserReviewModel(String reId, String reText, int reStarRating, String to_userId, String from_userId1,
			String userName, String userPw, String userAddress, int userReliability, Date reInDate) {
		super();
		this.reId = reId;
		this.reText = reText;
		this.reStarRating = reStarRating;
		this.to_userId = to_userId;
		this.from_userId1 = from_userId1;
		this.userName = userName;
		this.userPw = userPw;
		this.userAddress = userAddress;
		this.userReliability = userReliability;
		this.reInDate = reInDate;
	}

	public String getReId() {
		return reId;
	}

	public void setReId(String reId) {
		this.reId = reId;
	}

	public String getReText() {
		return reText;
	}

	public void setReText(String reText) {
		this.reText = reText;
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

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPw() {
		return userPw;
	}

	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}

	public String getUserAddress() {
		return userAddress;
	}

	public void setUserAddress(String userAddress) {
		this.userAddress = userAddress;
	}

	public int getUserReliability() {
		return userReliability;
	}

	public void setUserReliability(int userReliability) {
		this.userReliability = userReliability;
	}

	public Date getReInDate() {
		return reInDate;
	}

	public void setReInDate(Date reInDate) {
		this.reInDate = reInDate;
	}
			
}