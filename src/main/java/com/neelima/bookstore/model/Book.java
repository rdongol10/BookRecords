package com.neelima.bookstore.model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

import com.neelima.bookstore.dto.BookDto;

@Entity
public class Book {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;

	@OneToMany(mappedBy = "book", cascade = CascadeType.ALL)
	private List<BookInventory> bookInventory;

	@OneToMany(mappedBy = "book", cascade = CascadeType.ALL)
	private List<BookLog> bookLog;

	private String name;
	private String publisher;
	private String author;
	private double price;

	public Book() {
		super();
	}

	public Book(long id, List<BookInventory> bookInventory, List<BookLog> bookLog, String name, String publisher,
			String author, double price) {
		super();
		this.id = id;
		this.bookInventory = bookInventory;
		this.bookLog = bookLog;
		this.name = name;
		this.publisher = publisher;
		this.author = author;
		this.price = price;
	}

	public Book(BookDto bookDto) {
		this.id = bookDto.getId();
		this.name = bookDto.getName();
		this.publisher = bookDto.getPublisher();
		this.author = bookDto.getAuthor();
		this.price = bookDto.getPrice();
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public List<BookInventory> getBookInventory() {
		return bookInventory;
	}

	public void setBookInventory(List<BookInventory> bookInventory) {
		this.bookInventory = bookInventory;
	}

	public List<BookLog> getBookLog() {
		return bookLog;
	}

	public void setBookLog(List<BookLog> bookLog) {
		this.bookLog = bookLog;
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

}
