package com.neelima.bookstore.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.neelima.bookstore.model.Book;

public interface BookRepository extends JpaRepository<Book, Long> {

	boolean existsBookByName(String name);
}
