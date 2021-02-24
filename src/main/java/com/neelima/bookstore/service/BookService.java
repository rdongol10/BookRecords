package com.neelima.bookstore.service;

import java.util.Arrays;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neelima.bookstore.dto.BookDto;
import com.neelima.bookstore.model.Book;
import com.neelima.bookstore.model.BookInventory;
import com.neelima.bookstore.model.BookLog;
import com.neelima.bookstore.repository.BookRepository;

@Service
public class BookService {

	@Autowired
	private BookRepository bookRepository;

	@Autowired
	private UserService userService;

	@Autowired
	HttpSession session;

	public Book findById(Long id) {
		Optional<Book> book = bookRepository.findById(id);

		if (!book.isPresent()) {
			return null;
		}

		return book.get();
	}

	
	public BookDto findBookDtoById(Long id) {
		Book book = findById(id);
		if(book ==null) {
			return null;
		}
		
		return new BookDto(book.getId(), book.getName(), book.getPublisher(), book.getAuthor(),
				book.getPrice(), book.getBookInventory().get(0).getQuantity());
	}
	public Book addBook(BookDto bookDto) {

		Book book = new Book(bookDto);
		BookInventory bookInventory = new BookInventory(book, bookDto.getQuantity());

		BookLog bookLog = new BookLog(book, userService.findUserByUserName(session.getAttribute("userId").toString()),
				"Added", bookDto.getQuantity(), new Date());

		book.setBookInventory(Arrays.asList(bookInventory));
		book.setBookLog(Arrays.asList(bookLog));

		return bookRepository.save(book);

	}

	public boolean existsBookByName(String name) {
		return bookRepository.existsBookByName(name);
	}

	public List<BookDto> findAll() {
		List<Book> books = bookRepository.findAll();

		List<BookDto> bookDtos = new LinkedList<BookDto>();

		for (Book book : books) {
			bookDtos.add(new BookDto(book.getId(), book.getName(), book.getPublisher(), book.getAuthor(),
					book.getPrice(), book.getBookInventory().get(0).getQuantity()));
		}

		return bookDtos;
	}
	
	public Book update(long id, BookDto bookDto) {
		Book book = findById(id);
		if (book == null) {
			return null;
		}

		book.setPrice(bookDto.getPrice());
		book.setAuthor(bookDto.getAuthor());
		book.setPublisher(bookDto.getPublisher());

		return bookRepository.save(book);
	}

}
