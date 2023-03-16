package com.javalec.base.model;

import java.sql.Date;

public class NotiwriteModel {
	
	int N_notiId;
	int M_maId;
	Date notiInDate;
	Date notiMoDate;
	Date notiDelDate;
	
	
	public NotiwriteModel(int n_notiId, int m_maId, Date notiInDate, Date notiMoDate, Date notiDelDate) {
		super();
		N_notiId = n_notiId;
		M_maId = m_maId;
		this.notiInDate = notiInDate;
		this.notiMoDate = notiMoDate;
		this.notiDelDate = notiDelDate;
	}
	public int getN_notiId() {
		return N_notiId;
	}
	public void setN_notiId(int n_notiId) {
		N_notiId = n_notiId;
	}
	public int getM_maId() {
		return M_maId;
	}
	public void setM_maId(int m_maId) {
		M_maId = m_maId;
	}
	public Date getNotiInDate() {
		return notiInDate;
	}
	public void setNotiInDate(Date notiInDate) {
		this.notiInDate = notiInDate;
	}
	public Date getNotiMoDate() {
		return notiMoDate;
	}
	public void setNotiMoDate(Date notiMoDate) {
		this.notiMoDate = notiMoDate;
	}
	public Date getNotiDelDate() {
		return notiDelDate;
	}
	public void setNotiDelDate(Date notiDelDate) {
		this.notiDelDate = notiDelDate;
	}
	
	

}
