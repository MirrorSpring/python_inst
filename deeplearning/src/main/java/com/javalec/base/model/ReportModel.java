package com.javalec.base.model;

public class ReportModel {
	
	int repId;
	String repText;
	public ReportModel(int repId, String repText) {
		super();
		this.repId = repId;
		this.repText = repText;
	}
	public int getRepId() {
		return repId;
	}
	public void setRepId(int repId) {
		this.repId = repId;
	}
	public String getRepText() {
		return repText;
	}
	public void setRepText(String repText) {
		this.repText = repText;
	}
	
	

}
