package com.neelima.bookstore.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.neelima.bookstore.dto.BookInventoryDto;
import com.neelima.bookstore.model.BookInventory;
import com.neelima.bookstore.security.BookInventoryService;

@RestController
@RequestMapping("/bookInventory")
public class BookInventoryController {

	@Autowired
	private BookInventoryService bookInventoryService;

	@PostMapping("/addStock")
	public ResponseEntity<BookInventory> addStock(@RequestBody BookInventoryDto bookInventoryDto) {
		BookInventory bookInventory = bookInventoryService.addBookInventory(bookInventoryDto);
		if (bookInventory == null) {
			return ResponseEntity.badRequest().build();
		}

		return ResponseEntity.ok(bookInventory);

	}

}
