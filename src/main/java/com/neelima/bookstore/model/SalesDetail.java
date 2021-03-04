package com.neelima.bookstore.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.neelima.bookstore.dto.SalesDetailDto;

@Entity
public class SalesDetail {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;

	@ManyToOne
	@JoinColumn(name = "sales_id", nullable = false, updatable = true, insertable = true)
	@JsonIgnore
	private Sales sales;

	@ManyToOne
	@JoinColumn(name = "book_id", nullable = false, updatable = true, insertable = true)
	private Book book;

	private double price;
	
	private long quantity;

	private double total;

	public SalesDetail() {

	}

	public SalesDetail(long id, Sales sales, Book book, double price, int quantity, double total) {
		super();
		this.id = id;
		this.sales = sales;
		this.book = book;
		this.price = price;
		this.quantity = quantity;
		this.total = total;
	}

	public SalesDetail(SalesDetailDto salesDetailDto,Book book) {
		this.price=salesDetailDto.getPrice();
		this.quantity=salesDetailDto.getQuantity();
		this.total=salesDetailDto.getTotal();
		this.book=book;
	}
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Sales getSales() {
		return sales;
	}

	public void setSales(Sales sales) {
		this.sales = sales;
	}

	public Book getBook() {
		return book;
	}

	public void setBook(Book book) {
		this.book = book;
	}

	public long getQuantity() {
		return quantity;
	}

	
	public void setQuantity(long quantity) {
		this.quantity = quantity;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

}
