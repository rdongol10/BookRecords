package com.neelima.bookstore.dto;

public class Select2Dto {

	private long id;
	private String text;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public Select2Dto() {

	}

	public Select2Dto(long id, String text) {
		super();
		this.id = id;
		this.text = text;
	}

}
