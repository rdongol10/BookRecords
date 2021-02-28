package com.neelima.bookstore.dto;

public class BookInventoryDto {

	private long bookId;
	private long quantity;

	public BookInventoryDto() {

	}

	public BookInventoryDto(long bookId, long quantity) {
		super();
		this.bookId = bookId;
		this.quantity = quantity;
	}

	public long getBookId() {
		return bookId;
	}

	public void setBookId(long bookId) {
		this.bookId = bookId;
	}

	public long getQuantity() {
		return quantity;
	}

	public void setQuantity(long quantity) {
		this.quantity = quantity;
	}

}
