package com.javalec.base.model;

import java.sql.Date;

public class ManagerModel {
	
	int maId;
	String maName;
	int maPw;
	Date maInDate;
	Date maMoDate;
	Date maDelDate;
	
	public ManagerModel(int maId, String maName, int maPw, Date maInDate, Date maMoDate, Date maDelDate) {
		super();
		this.maId = maId;
		this.maName = maName;
		this.maPw = maPw;
		this.maInDate = maInDate;
		this.maMoDate = maMoDate;
		this.maDelDate = maDelDate;
	}
	public int getMaId() {
		return maId;
	}
	public void setMaId(int maId) {
		this.maId = maId;
	}
	public String getMaName() {
		return maName;
	}
	public void setMaName(String maName) {
		this.maName = maName;
	}
	public int getMaPw() {
		return maPw;
	}
	public void setMaPw(int maPw) {
		this.maPw = maPw;
	}
	public Date getMaInDate() {
		return maInDate;
	}
	public void setMaInDate(Date maInDate) {
		this.maInDate = maInDate;
	}
	public Date getMaMoDate() {
		return maMoDate;
	}
	public void setMaMoDate(Date maMoDate) {
		this.maMoDate = maMoDate;
	}
	public Date getMaDelDate() {
		return maDelDate;
	}
	public void setMaDelDate(Date maDelDate) {
		this.maDelDate = maDelDate;
	}
	
	
	

}
