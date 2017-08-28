/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: User.java
* Copyright 2017-08-28 By Gnosis. Allright reserved.
* Time: ����9:06:35
*/
package com.chinasofti.day03.model.vo;

public class User {
	private String id;

	public User() {
		super();
	}

	public User(String id, String username, String password, int age) {
		this.id = id;
		this.username = username;
		this.password = password;
		this.age = age;
	}

	private String username;
	private String password;
	private int age;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", age=" + age + "]";
	}

}
