package com.neelima.bookstore.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
public class BookLog {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;

	@ManyToOne
	@JoinColumn(name = "book_id", nullable = false, updatable = true, insertable = true)
	@JsonIgnore
	private Book book;

	@ManyToOne
	@JoinColumn(name = "user_id", nullable = false, updatable = true, insertable = true)
	@JsonIgnore
	private User user;

	private String type;

	private long quantity;

	private Date date;

	public BookLog() {
		super();
	}

	public BookLog(long id, Book book, User user, String type, long quantity, Date date) {
		super();
		this.id = id;
		this.book = book;
		this.user = user;
		this.type = type;
		this.quantity = quantity;
		this.date = date;
	}

	public BookLog(Book book, User user, String type, long quantity, Date date) {
		super();
		this.book = book;
		this.user = user;
		this.type = type;
		this.quantity = quantity;
		this.date = date;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public Book getBook() {
		return book;
	}

	public void setBook(Book book) {
		this.book = book;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public long getQuantity() {
		return quantity;
	}

	public void setQuantity(long quantity) {
		this.quantity = quantity;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

}
