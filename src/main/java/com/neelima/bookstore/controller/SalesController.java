package com.neelima.bookstore.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.neelima.bookstore.dto.SalesDto;
import com.neelima.bookstore.dto.SalesRecordsFilter;
import com.neelima.bookstore.model.Sales;
import com.neelima.bookstore.service.SalesService;

@RestController
@RequestMapping("/sales")
public class SalesController {

	@Autowired
	private SalesService salesService;

	@PostMapping
	public ResponseEntity<Sales> create(@RequestBody SalesDto salesDto) {

		Sales sale = salesService.addSales(salesDto);
		if (sale == null) {
			return ResponseEntity.badRequest().build();
		} else {

			return ResponseEntity.ok(sale);
		}
	}

	@PostMapping("/getSalesRecords")
	public ResponseEntity<List<SalesDto>> getSalesRecords(@RequestBody SalesRecordsFilter salesRecordsFilter) {

		return ResponseEntity.ok(salesService.getSalesRecords(salesRecordsFilter));

	}

	@GetMapping("/{id}")
	public ResponseEntity<Sales> getSales(@PathVariable Long id) {
		Sales sales = salesService.findById(id);
		if (sales == null) {
			return ResponseEntity.badRequest().build();
		}
		return ResponseEntity.ok(sales);
	}
}
