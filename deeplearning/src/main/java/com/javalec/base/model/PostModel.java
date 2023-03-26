package com.javalec.base.model;

public class PostModel {
	int poId;
	int poHeart;
	String poTitle;
	String poContent;
	String poPrice;
	String poImage01;
	String poImage02;
	String poInstrument;
	int poViews;
	int poState;
	String poUser;
	
	public PostModel(int poId, int poHeart, String poTitle, String poContent, String poPrice, String poImage01,
			String poImage02, String poInstrument, int poViews, int poState, String poUser) {
		super();
		this.poId = poId;
		this.poHeart = poHeart;
		this.poTitle = poTitle;
		this.poContent = poContent;
		this.poPrice = poPrice;
		this.poImage01 = poImage01;
		this.poImage02 = poImage02;
		this.poInstrument = poInstrument;
		this.poViews = poViews;
		this.poState = poState;
		this.poUser = poUser;
	}

	public int getPoId() {
		return poId;
	}

	public void setPoId(int poId) {
		this.poId = poId;
	}

	public int getPoHeart() {
		return poHeart;
	}

	public void setPoHeart(int poHeart) {
		this.poHeart = poHeart;
	}

	public String getPoTitle() {
		return poTitle;
	}

	public void setPoTitle(String poTitle) {
		this.poTitle = poTitle;
	}

	public String getPoContent() {
		return poContent;
	}

	public void setPoContent(String poContent) {
		this.poContent = poContent;
	}

	public String getPoPrice() {
		return poPrice;
	}

	public void setPoPrice(String poPrice) {
		this.poPrice = poPrice;
	}

	public String getPoImage01() {
		return poImage01;
	}

	public void setPoImage01(String poImage01) {
		this.poImage01 = poImage01;
	}

	public String getPoImage02() {
		return poImage02;
	}

	public void setPoImage02(String poImage02) {
		this.poImage02 = poImage02;
	}

	public String getPoInstrument() {
		return poInstrument;
	}

	public void setPoInstrument(String poInstrument) {
		this.poInstrument = poInstrument;
	}

	public int getPoViews() {
		return poViews;
	}

	public void setPoViews(int poViews) {
		this.poViews = poViews;
	}

	public int getPoState() {
		return poState;
	}

	public void setPoState(int poState) {
		this.poState = poState;
	}

	public String getPoUser() {
		return poUser;
	}

	public void setPoUser(String poUser) {
		this.poUser = poUser;
	}
	
	
	

}
