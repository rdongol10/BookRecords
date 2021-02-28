package com.neelima.bookstore.controller;

import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neelima.bookstore.model.Book;
import com.neelima.bookstore.model.BookLog;
import com.neelima.bookstore.repository.BookLogRepository;
import com.neelima.bookstore.service.UserService;

@Service
public class BookLogService {

	@Autowired
	HttpSession session;

	@Autowired
	private UserService userService;

	@Autowired
	private BookLogRepository bookLogRepository;

	public BookLog recordBookLog(Book book, long quantity, String action) {

		if (book == null) {
			return null;
		}

		BookLog bookLog = new BookLog(book, userService.findUserByUserName(session.getAttribute("userId").toString()),
				action, quantity, new Date());

		return bookLogRepository.save(bookLog);
	}

}
