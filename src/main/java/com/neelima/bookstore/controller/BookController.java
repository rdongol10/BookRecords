package com.neelima.bookstore.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.neelima.bookstore.dto.BookDto;
import com.neelima.bookstore.dto.Select2Dto;
import com.neelima.bookstore.model.Book;
import com.neelima.bookstore.service.BookService;

@RestController
@RequestMapping("/book")
public class BookController {

	@Autowired
	private BookService bookService;

	@GetMapping
	public ResponseEntity<List<BookDto>> findAll() {
		return ResponseEntity.ok(bookService.findAll());
	}

	@PostMapping
	public ResponseEntity<Book> create(@RequestBody BookDto bookDto) {
		return ResponseEntity.ok(bookService.addBook(bookDto));
	}

	@GetMapping("/bookexists/{name}")
	public Boolean doesBookExists(@PathVariable String name) {
		return bookService.existsBookByName(name);
	}

	@GetMapping("/{id}")
	public ResponseEntity<BookDto> findById(@PathVariable Long id) {
		BookDto bookDto = bookService.findBookDtoById(id);
		if (bookDto == null) {
			return ResponseEntity.badRequest().build();
		}
		return ResponseEntity.ok(bookDto);
	}

	@PutMapping("/{id}")
	public ResponseEntity<Book> update(@PathVariable Long id, @RequestBody BookDto bookDto) {
		Book book = bookService.update(id, bookDto);
		if (book == null) {
			return ResponseEntity.badRequest().build();
		}
		return ResponseEntity.ok(book);
	}

	@PostMapping("/getBooksForSelect2")
	public ResponseEntity<List<Select2Dto>> getBooksForSelect2(String search) {

		return ResponseEntity.ok(bookService.findBooksContainingName(search));

	}

}
