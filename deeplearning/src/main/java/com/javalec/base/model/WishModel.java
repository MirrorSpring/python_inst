package com.javalec.base.model;

import java.sql.Date;

public class WishModel {
	
	String U_userId;
	int P_poId;
	Date WishDate;
	Date WishDelDate;
	
	public WishModel(String u_userId, int p_poId, Date wishDate, Date wishDelDate) {
		super();
		U_userId = u_userId;
		P_poId = p_poId;
		WishDate = wishDate;
		WishDelDate = wishDelDate;
	}
	public String getU_userId() {
		return U_userId;
	}
	public void setU_userId(String u_userId) {
		U_userId = u_userId;
	}
	public int getP_poId() {
		return P_poId;
	}
	public void setP_poId(int p_poId) {
		P_poId = p_poId;
	}
	public Date getWishDate() {
		return WishDate;
	}
	public void setWishDate(Date wishDate) {
		WishDate = wishDate;
	}
	public Date getWishDelDate() {
		return WishDelDate;
	}
	public void setWishDelDate(Date wishDelDate) {
		WishDelDate = wishDelDate;
	}
	
	

}
