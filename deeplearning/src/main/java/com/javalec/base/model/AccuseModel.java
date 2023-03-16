package com.javalec.base.model;

public class AccuseModel {
	
	int R_repId;
	String U_userId;
	

	
	public AccuseModel(int r_repId, String u_userId) {
		super();
		R_repId = r_repId;
		U_userId = u_userId;
	}
	public int getR_repId() {
		return R_repId;
	}
	public void setR_repId(int r_repId) {
		R_repId = r_repId;
	}
	public String getU_userId() {
		return U_userId;
	}
	public void setU_userId(String u_userId) {
		U_userId = u_userId;
	}
	
	
}
