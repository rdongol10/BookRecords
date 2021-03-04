package com.neelima.bookstore.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.neelima.bookstore.dto.SalesDto;
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

}
