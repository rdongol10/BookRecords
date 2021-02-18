package com.neelima.bookstore.service;

import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neelima.bookstore.dto.UserDto;
import com.neelima.bookstore.model.User;
import com.neelima.bookstore.repository.UserRepository;

@Service
public class UserService {

	@Autowired
	private UserRepository userRepository;

	public List<UserDto> findAll() {
		List<User> users = userRepository.findAll();

		List<UserDto> userDtos = new LinkedList<UserDto>();
		for (User user : users) {
			userDtos.add(new UserDto(user));
		}
		return userDtos;
	}

	public Optional<User> findById(Long id) {
		return userRepository.findById(id);
	}

	public User save(User user) {
		return userRepository.save(user);
	}

	public void deleteById(Long id) {
		userRepository.deleteById(id);
	}

	public boolean existUserByLoginName(String loginName) {
		return userRepository.existsUserByLoginName(loginName);
	}

	public User findUserByUserName(String loginName) {
		return userRepository.findUserByLoginName(loginName);
	}

	public User findUserByEmailAddress(String emailAddress) {
		return userRepository.findUserByEmailAddress(emailAddress);
	}
}
