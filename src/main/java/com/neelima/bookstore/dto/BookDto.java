package com.neelima.bookstore.dto;

public class BookDto {

	private long id;
	private String name;
	private String publisher;
	private String author;
	private double price;
	private long quantity;

	public BookDto(long id, String name, String publisher, String author, double price, long quantity) {
		super();
		this.id = id;
		this.name = name;
		this.publisher = publisher;
		this.author = author;
		this.price = price;
		this.quantity = quantity;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPublisher() {
		return publisher;
	}

	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public long getQuantity() {
		return quantity;
	}

	public void setQuantity(long quantity) {
		this.quantity = quantity;
	}

}
