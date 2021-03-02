package com.neelima.bookstore.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.neelima.bookstore.model.Sales;

public interface SalesRepository extends JpaRepository<Sales, Long> {

}
