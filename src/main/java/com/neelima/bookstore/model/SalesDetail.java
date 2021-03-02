package com.neelima.bookstore.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;

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

	private int quantity;

	private double total;

	public SalesDetail() {

	}

	public SalesDetail(long id, Sales sales, Book book, int quantity, double total) {
		super();
		this.id = id;
		this.sales = sales;
		this.book = book;
		this.quantity = quantity;
		this.total = total;
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

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public double getTotal() {
		return total;
	}

	public void setTotal(double total) {
		this.total = total;
	}

}
