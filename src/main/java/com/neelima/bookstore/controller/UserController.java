package com.neelima.bookstore.controller;

import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.neelima.bookstore.dto.PasswordDTO;
import com.neelima.bookstore.dto.UserDto;
import com.neelima.bookstore.model.User;
import com.neelima.bookstore.service.UserService;

@RestController
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	HttpSession session;

	@GetMapping
	public ResponseEntity<List<UserDto>> findAll() {
		return ResponseEntity.ok(userService.findAll());
	}

	@GetMapping("/{id}")
	public ResponseEntity<User> findById(@PathVariable Long id) {
		Optional<User> user = userService.findById(id);
		if (!user.isPresent()) {
			return ResponseEntity.badRequest().build();
		}

		return ResponseEntity.ok(user.get());
	}

	@GetMapping("/userExists/{loginName}")
	public String doesUserExists(@PathVariable String loginName) {

		if (userService.existUserByLoginName(loginName)) {
			return "true";
		}

		return "false";
	}

	@PostMapping
	public ResponseEntity<User> create(User user) {
		String password = new BCryptPasswordEncoder().encode(user.getPassword());
		user.setPassword(password);
		return ResponseEntity.ok(userService.save(user));
	}

	@PutMapping("/{id}")
	public ResponseEntity<User> update(@PathVariable Long id, User user) {
		if (!userService.findById(id).isPresent()) {
			return ResponseEntity.badRequest().build();
		}

		User currentUser = userService.findById(id).get();

		currentUser.setFirstName(user.getFirstName());
		currentUser.setMiddleName(user.getMiddleName());
		currentUser.setLastName(user.getLastName());
		currentUser.setPhoneNumber(user.getPhoneNumber());
		currentUser.setEmailAddress(user.getEmailAddress());
		currentUser.setSex(user.getSex());
		currentUser.setTypeOfUser(user.getTypeOfUser());

		return ResponseEntity.ok(userService.save(currentUser));
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<User> delete(@PathVariable Long id) {
		if (!userService.findById(id).isPresent()) {
			return ResponseEntity.badRequest().build();
		}

		userService.deleteById(id);

		return ResponseEntity.ok().build();
	}

	@PostMapping("/comparePassword")
	public boolean comparePassword(@RequestBody String password) {

		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		User user = userService.findUserByUserName(session.getAttribute("userId").toString());

		return encoder.matches(password, user.getPassword());

	}

	@PutMapping("/updatePassword")
	public boolean updatePassword(@RequestBody PasswordDTO passwordDto) {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

		User user = userService.findUserByUserName(session.getAttribute("userId").toString());

		if (!encoder.matches(passwordDto.getOldPassword(), user.getPassword())) {
			return false;
		}

		if (!passwordDto.getNewPassword().equals(passwordDto.getConfirmPassword())) {
			return false;
		}

		user.setPassword(new BCryptPasswordEncoder().encode(passwordDto.getNewPassword()));
		userService.save(user);

		return true;
	}

}
