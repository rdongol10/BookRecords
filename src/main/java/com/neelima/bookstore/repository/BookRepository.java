package com.neelima.bookstore.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.neelima.bookstore.model.Book;

public interface BookRepository extends JpaRepository<Book, Long> {

	boolean existsBookByName(String name);
	
	List<Book> findByNameContaining(String name);
}
