package com.javalec.base.model;

import java.sql.Date;

public class CommentModel {
	
	
	int coId;
	int P_poId;
	String U_userId;
	String comment;
	Date coInDate;
	Date coMoDate;
	Date coDelDate;
	
	
	public CommentModel(int coId, int p_poId, String u_userId, String comment, Date coInDate, Date coMoDate,
			Date coDelDate) {
		super();
		this.coId = coId;
		P_poId = p_poId;
		U_userId = u_userId;
		this.comment = comment;
		this.coInDate = coInDate;
		this.coMoDate = coMoDate;
		this.coDelDate = coDelDate;
	}
	public int getCoId() {
		return coId;
	}
	public void setCoId(int coId) {
		this.coId = coId;
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
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public Date getCoInDate() {
		return coInDate;
	}
	public void setCoInDate(Date coInDate) {
		this.coInDate = coInDate;
	}
	public Date getCoMoDate() {
		return coMoDate;
	}
	public void setCoMoDate(Date coMoDate) {
		this.coMoDate = coMoDate;
	}
	public Date getCoDelDate() {
		return coDelDate;
	}
	public void setCoDelDate(Date coDelDate) {
		this.coDelDate = coDelDate;
	}
	
	
	

}
