package com.javalec.base.model;

public class NotificationModel {
	
	int notiId;
	String notiTitle;
	String notiText;
	
	public NotificationModel(int notiId, String notiTitle, String notiText) {
		super();
		this.notiId = notiId;
		this.notiTitle = notiTitle;
		this.notiText = notiText;
	}
	public int getNotiId() {
		return notiId;
	}
	public void setNotiId(int notiId) {
		this.notiId = notiId;
	}
	public String getNotiTitle() {
		return notiTitle;
	}
	public void setNotiTitle(String notiTitle) {
		this.notiTitle = notiTitle;
	}
	public String getNotiText() {
		return notiText;
	}
	public void setNotiText(String notiText) {
		this.notiText = notiText;
	}
	
	

}
