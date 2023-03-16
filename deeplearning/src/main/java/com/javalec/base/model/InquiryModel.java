package com.javalec.base.model;

import java.sql.Date;

public class InquiryModel {
	
	int inqId;
	int M_maId;
	String U_userId;
	String inqText;
	Date inqDate;
	int inqState;
	String inqAnswer;
	
	public InquiryModel(int inqId, int m_maId, String u_userId, String inqText, Date inqDate, int inqState,
			String inqAnswer) {
		super();
		this.inqId = inqId;
		M_maId = m_maId;
		U_userId = u_userId;
		this.inqText = inqText;
		this.inqDate = inqDate;
		this.inqState = inqState;
		this.inqAnswer = inqAnswer;
	}
	public int getInqId() {
		return inqId;
	}
	public void setInqId(int inqId) {
		this.inqId = inqId;
	}
	public int getM_maId() {
		return M_maId;
	}
	public void setM_maId(int m_maId) {
		M_maId = m_maId;
	}
	public String getU_userId() {
		return U_userId;
	}
	public void setU_userId(String u_userId) {
		U_userId = u_userId;
	}
	public String getInqText() {
		return inqText;
	}
	public void setInqText(String inqText) {
		this.inqText = inqText;
	}
	public Date getInqDate() {
		return inqDate;
	}
	public void setInqDate(Date inqDate) {
		this.inqDate = inqDate;
	}
	public int getInqState() {
		return inqState;
	}
	public void setInqState(int inqState) {
		this.inqState = inqState;
	}
	public String getInqAnswer() {
		return inqAnswer;
	}
	public void setInqAnswer(String inqAnswer) {
		this.inqAnswer = inqAnswer;
	}
	
	
	

}
