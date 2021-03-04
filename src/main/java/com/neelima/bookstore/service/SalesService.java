package com.neelima.bookstore.service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neelima.bookstore.controller.BookLogService;
import com.neelima.bookstore.dto.SalesDetailDto;
import com.neelima.bookstore.dto.SalesDto;
import com.neelima.bookstore.dto.SalesRecordsFilter;
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

	@PersistenceContext
	protected EntityManager entityManager;

	@Transactional
	public Sales addSales(SalesDto salesDto) {
		Sales sales = new Sales(salesDto);

		User user = userService.findUserByUserName(session.getAttribute("userId").toString());

		if (user == null) {
			return null;
		}
		List<SalesDetailDto> salesDetailDtos = salesDto.getSalesDetailDto();
		List<SalesDetail> salesDetails = new ArrayList<SalesDetail>();
		List<BookInventory> bookInventories = new ArrayList<BookInventory>();
		List<BookLog> bookLogs = new ArrayList<BookLog>();
		for (SalesDetailDto salesDetailDto : salesDetailDtos) {
			Book book = bookService.findById(salesDetailDto.getBookId());
			if (book == null) {
				return null;
			}

			SalesDetail salesDetail = new SalesDetail(salesDetailDto, book);
			salesDetail.setSales(sales);
			salesDetails.add(salesDetail);
			BookInventory bookInventory = bookInventoryService.findByBook(book);
			if (bookInventory == null) {
				return null;
			}

			bookInventory.setQuantity(bookInventory.getQuantity() - salesDetailDto.getQuantity());
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

	public List<SalesDto> getSalesRecords(SalesRecordsFilter salesRecordsFilter) {

		StringBuilder queryString = new StringBuilder();
		String startDate = salesRecordsFilter.getStartDate();
		String endDate = salesRecordsFilter.getEndDate();

		queryString.append("SELECT   s.id,  u.login_name,  s.sold_Date,  s.grand_total,  s.tax,  s.vat,  s.net_total ");
		queryString.append(" FROM  sales s,  USER u WHERE s.sold_by = u.id ");
		queryString.append(" AND s.sold_Date BETWEEN '" + startDate + "' ");
		queryString.append("  AND '" + endDate + "'");
		Query query = entityManager.createNativeQuery(queryString.toString());

		List<Object[]> objects = query.getResultList();
		List<SalesDto> salesDtos = new ArrayList<SalesDto>();
		for (Object[] object : objects) {
			SalesDto salesDto = new SalesDto();
			salesDto.setId(Long.valueOf(String.valueOf(object[0])));
			salesDto.setUser(String.valueOf(object[1]));
			salesDto.setSoldDate((Date) object[2]);
			salesDto.setGrandTotal(Double.valueOf(String.valueOf(object[3])));
			salesDto.setTax(Double.valueOf(String.valueOf(object[4])));
			salesDto.setVat(Double.valueOf(String.valueOf(object[5])));
			salesDto.setNetTotal(Double.valueOf(String.valueOf(object[6])));
			salesDtos.add(salesDto);
		}

		return salesDtos;
	}

	protected String formatDate(Object object) {

		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		if (object == null) {
			return "";
		}

		if (!(object instanceof Date)) {
			return String.valueOf(object);
		}

		Date date = (Date) object;
		return df.format(date);

	}

	public Sales findById(Long id) {
		Optional<Sales> sales = salesRepository.findById(id);
		if (!sales.isPresent()) {
			return null;
		}

		return sales.get();
	}

}
