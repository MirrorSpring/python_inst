package com.javalec.base.model;

import java.sql.Date;
import java.sql.Time;

public class Join_PostUploadModel {
	int poId;	
	int poHeart;	
	String poTitle;	
	String poContent;	
	String poPrice;	
	String poImage01;	
	String poImage02;	
	String poInstrument;	
	int poViews;	
	int poState;	
	String poUser;
	String U_userId;	
	String userAddress;
	int userReliability;
	Date poUpDate;	
	Time timeonly;
	
	
	
	
	public Join_PostUploadModel(int poId, int poHeart, String poTitle, String poContent, String poPrice,
			String poImage01, String poImage02, String poInstrument, int poViews, int poState, String poUser,
			String u_userId, String userAddress, int userReliability, Date poUpDate, Time timeonly) {
		super();
		this.poId = poId;
		this.poHeart = poHeart;
		this.poTitle = poTitle;
		this.poContent = poContent;
		this.poPrice = poPrice;
		this.poImage01 = poImage01;
		this.poImage02 = poImage02;
		this.poInstrument = poInstrument;
		this.poViews = poViews;
		this.poState = poState;
		this.poUser = poUser;
		U_userId = u_userId;
		this.userAddress = userAddress;
		this.userReliability = userReliability;
		this.poUpDate = poUpDate;
		this.timeonly = timeonly;
	}
	public int getPoId() {
		return poId;
	}
	public void setPoId(int poId) {
		this.poId = poId;
	}
	public int getPoHeart() {
		return poHeart;
	}
	public void setPoHeart(int poHeart) {
		this.poHeart = poHeart;
	}
	public String getPoTitle() {
		return poTitle;
	}
	public void setPoTitle(String poTitle) {
		this.poTitle = poTitle;
	}
	public String getPoContent() {
		return poContent;
	}
	public void setPoContent(String poContent) {
		this.poContent = poContent;
	}
	public String getPoPrice() {
		return poPrice;
	}
	public void setPoPrice(String poPrice) {
		this.poPrice = poPrice;
	}
	public String getPoImage01() {
		return poImage01;
	}
	public void setPoImage01(String poImage01) {
		this.poImage01 = poImage01;
	}
	public String getPoImage02() {
		return poImage02;
	}
	public void setPoImage02(String poImage02) {
		this.poImage02 = poImage02;
	}
	public String getPoInstrument() {
		return poInstrument;
	}
	public void setPoInstrument(String poInstrument) {
		this.poInstrument = poInstrument;
	}
	public int getPoViews() {
		return poViews;
	}
	public void setPoViews(int poViews) {
		this.poViews = poViews;
	}
	public int getPoState() {
		return poState;
	}
	public void setPoState(int poState) {
		this.poState = poState;
	}
	public String getPoUser() {
		return poUser;
	}
	public void setPoUser(String poUser) {
		this.poUser = poUser;
	}
	public String getU_userId() {
		return U_userId;
	}
	public void setU_userId(String u_userId) {
		U_userId = u_userId;
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
	public Date getPoUpDate() {
		return poUpDate;
	}
	public void setPoUpDate(Date poUpDate) {
		this.poUpDate = poUpDate;
	}
	public Time getTimeonly() {
		return timeonly;
	}
	public void setTimeonly(Time timeonly) {
		this.timeonly = timeonly;
	}
	
	
	
	
	
	
	
	

	

}
