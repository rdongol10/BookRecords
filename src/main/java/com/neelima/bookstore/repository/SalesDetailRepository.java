package com.neelima.bookstore.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.neelima.bookstore.model.SalesDetail;

public interface SalesDetailRepository extends JpaRepository<SalesDetail, Long> {

}
