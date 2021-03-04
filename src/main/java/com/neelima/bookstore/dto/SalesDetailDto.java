package com.neelima.bookstore.dto;

public class SalesDetailDto {

	private long bookId;
	private double price;
	private long quantity;
	private double total;

	public SalesDetailDto() {

	}

	public SalesDetailDto(long bookId, double price, long quantity, double total) {
		super();
		this.bookId = bookId;
		this.price = price;
		this.quantity = quantity;
		this.total = total;
	}

	public long getBookId() {
		return bookId;
	}

	public void setBookId(long bookId) {
		this.bookId = bookId;
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

	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

}
