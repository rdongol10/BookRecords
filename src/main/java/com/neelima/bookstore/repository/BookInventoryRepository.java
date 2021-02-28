package com.neelima.bookstore.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.neelima.bookstore.model.Book;
import com.neelima.bookstore.model.BookInventory;

public interface BookInventoryRepository extends JpaRepository<BookInventory, Long> {

	BookInventory findBookInventoryByBook(Book book);
}
