package com.neelima.bookstore.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.neelima.bookstore.model.User;

public interface UserRepository extends JpaRepository<User, Long> {
	boolean existsUserByLoginName(String loginName);

	User findUserByLoginName(String loginName);

	User findUserByEmailAddress(String emailAddress);
}
