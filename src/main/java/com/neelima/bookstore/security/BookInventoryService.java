package com.neelima.bookstore.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.neelima.bookstore.controller.BookLogService;
import com.neelima.bookstore.dto.BookInventoryDto;
import com.neelima.bookstore.model.Book;
import com.neelima.bookstore.model.BookInventory;
import com.neelima.bookstore.model.BookLog;
import com.neelima.bookstore.repository.BookInventoryRepository;
import com.neelima.bookstore.service.BookService;

@Service
public class BookInventoryService {

	@Autowired
	private BookService bookService;

	@Autowired
	private BookInventoryRepository bookInventoryRepository;

	@Autowired
	private BookLogService bookLogService;

	@Transactional
	public BookInventory addBookInventory(BookInventoryDto bookInventoryDto) {

		Book book = bookService.findById(bookInventoryDto.getBookId());
		if (book == null) {
			return null;
		}

		BookLog bookLog = bookLogService.recordBookLog(book, bookInventoryDto.getQuantity(), "ADDED");
		if (bookLog == null) {
			return null;
		}

		BookInventory bookInventory = bookInventoryRepository.findBookInventoryByBook(book);

		if (bookInventory != null) {
			long quantity = bookInventory.getQuantity() + bookInventoryDto.getQuantity();
			bookInventory.setQuantity(quantity);
		} else {
			bookInventory = new BookInventory(book, bookInventoryDto.getQuantity());
		}
		return bookInventoryRepository.save(bookInventory);

	}
}
