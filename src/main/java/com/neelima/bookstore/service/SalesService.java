package com.neelima.bookstore.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neelima.bookstore.controller.BookLogService;
import com.neelima.bookstore.dto.SalesDetailDto;
import com.neelima.bookstore.dto.SalesDto;
import com.neelima.bookstore.model.Book;
import com.neelima.bookstore.model.BookInventory;
import com.neelima.bookstore.model.BookLog;
import com.neelima.bookstore.model.Sales;
import com.neelima.bookstore.model.SalesDetail;
import com.neelima.bookstore.model.User;
import com.neelima.bookstore.repository.SalesRepository;
import com.neelima.bookstore.security.BookInventoryService;

@Service
public class SalesService {

	@Autowired
	private SalesRepository salesRepository;
	
	@Autowired
	private BookService bookService;
	
	@Autowired
	private BookInventoryService bookInventoryService;
	
	@Autowired
	private BookLogService bookLogService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	HttpSession session;

	@Transactional
	public Sales addSales(SalesDto salesDto) {
		Sales sales = new Sales(salesDto);
		
		User user = userService.findUserByUserName(session.getAttribute("userId").toString());
		
		if(user==null) {
			return null;
		}
		List<SalesDetailDto> salesDetailDtos = salesDto.getSalesDetailDto();
		List<SalesDetail> salesDetails= new ArrayList<SalesDetail>();
		List<BookInventory> bookInventories = new ArrayList<BookInventory>();
		List<BookLog> bookLogs= new ArrayList<BookLog>();
		for(SalesDetailDto salesDetailDto:salesDetailDtos) {
			Book book = bookService.findById(salesDetailDto.getBookId());
			if(book ==null) {
				return null;
			}
		
			SalesDetail salesDetail = new SalesDetail(salesDetailDto, book);
			salesDetail.setSales(sales);
			salesDetails.add(salesDetail);
			BookInventory bookInventory = bookInventoryService.findByBook(book);
			if(bookInventory==null) {
				return null;
			}
			
			
			bookInventory.setQuantity(bookInventory.getQuantity()-salesDetailDto.getQuantity());
			bookInventories.add(bookInventory);
			
			BookLog bookLog = new BookLog(book, user, "Sales", salesDetailDto.getQuantity(), new Date());
			bookLogs.add(bookLog);
			
			
		}
		sales.setUser(user);
		sales.setSalesDetail(salesDetails);
		
		
		salesRepository.save(sales);
		bookLogService.recordBookLogs(bookLogs);
		bookInventoryService.saveBookInvetories(bookInventories);
		
		return sales;
	}
}
