package com.javalec.base.model;
import java.sql.Date;

public class BuyModel {
	
	int P_poId;
	String U_userId;
	Date buydate;
	public BuyModel(int p_poId, String u_userId, Date buydate) {
		super();
		P_poId = p_poId;
		U_userId = u_userId;
		this.buydate = buydate;
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
	public Date getBuydate() {
		return buydate;
	}
	public void setBuydate(Date buydate) {
		this.buydate = buydate;
	}
	
	
	
	

}
