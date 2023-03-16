package com.javalec.base.model;

import java.sql.Date;

public class UploadModel {
	
	int P_poId;
	String U_userId;
	Date poDelDate;
	Date poUpDate;
	Date poMoDate;
	
	
	
	
	public UploadModel(int p_poId, String u_userId, Date poDelDate, Date poUpDate, Date poMoDate) {
		super();
		P_poId = p_poId;
		U_userId = u_userId;
		this.poDelDate = poDelDate;
		this.poUpDate = poUpDate;
		this.poMoDate = poMoDate;
	}
	public int getP_poId() {
		return P_poId;
	}
	public void setP_poId(int p_poId) {
		P_poId = p_poId;
	}
	public String getU_userId() {
		return U_userId;
	}
	public void setU_userId(String u_userId) {
		U_userId = u_userId;
	}
	public Date getPoDelDate() {
		return poDelDate;
	}
	public void setPoDelDate(Date poDelDate) {
		this.poDelDate = poDelDate;
	}
	public Date getPoUpDate() {
		return poUpDate;
	}
	public void setPoUpDate(Date poUpDate) {
		this.poUpDate = poUpDate;
	}
	public Date getPoMoDate() {
		return poMoDate;
	}
	public void setPoMoDate(Date poMoDate) {
		this.poMoDate = poMoDate;
	}
	
	

}
