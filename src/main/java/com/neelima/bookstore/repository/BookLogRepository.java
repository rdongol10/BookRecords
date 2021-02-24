package com.neelima.bookstore.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.neelima.bookstore.model.BookLog;

public interface BookLogRepository extends JpaRepository<BookLog, Long> {

}
