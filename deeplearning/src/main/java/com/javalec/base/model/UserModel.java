package com.javalec.base.model;

import java.sql.Date;

public class UserModel {
	String userId;
	String userName;
	String userPw;
	String userAddress;
	Date userInDate;
	Date userDelDate;
	int userReliability;
	

	
	public UserModel(String userId, String userName, String userPw, String userAddress, Date userInDate,
			Date userDelDate, int userReliability) {
		super();
		this.userId = userId;
		this.userName = userName;
		this.userPw = userPw;
		this.userAddress = userAddress;
		this.userInDate = userInDate;
		this.userDelDate = userDelDate;
		this.userReliability = userReliability;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
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
	public Date getUserInDate() {
		return userInDate;
	}
	public void setUserInDate(Date userInDate) {
		this.userInDate = userInDate;
	}
	public Date getUserDelDate() {
		return userDelDate;
	}
	public void setUserDelDate(Date userDelDate) {
		this.userDelDate = userDelDate;
	}
	public int getUserReliability() {
		return userReliability;
	}
	public void setUserReliability(int userReliability) {
		this.userReliability = userReliability;
	}
	
	
	
	
	
	
	
}
