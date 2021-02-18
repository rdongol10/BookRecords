package com.neelima.bookstore.dto;

import com.neelima.bookstore.model.User;

public class UserDto {

	private long id;
	private String userName;
	private String firstName;
	private String middleName;
	private String lastName;
	private String sex;
	private String phoneNumber;
	private String email;
	private String typeOfUser;

	public UserDto() {

	}

	public UserDto(long id, String userName, String firstName, String middleName, String lastName, String sex,
			String phoneNumber, String email, String typeOfUser) {
		super();
		this.id = id;
		this.userName = userName;
		this.firstName = firstName;
		this.middleName = middleName;
		this.lastName = lastName;
		this.sex = sex;
		this.phoneNumber = phoneNumber;
		this.email = email;
		this.typeOfUser = typeOfUser;
	}

	public UserDto(User user) {
		super();
		this.id = user.getId();
		this.userName = user.getLoginName();
		this.firstName = user.getFirstName();
		this.middleName = user.getMiddleName();
		this.lastName = user.getLastName();
		this.sex = user.getSex();
		this.phoneNumber = user.getPhoneNumber();
		this.email = user.getEmailAddress();
		this.typeOfUser = user.getTypeOfUser();
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getMiddleName() {
		return middleName;
	}

	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTypeOfUser() {
		return typeOfUser;
	}

	public void setTypeOfUser(String typeOfUser) {
		this.typeOfUser = typeOfUser;
	}

}
