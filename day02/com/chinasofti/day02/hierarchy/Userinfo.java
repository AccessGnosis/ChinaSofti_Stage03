/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: Userinfo.java
* Copyright 2017-08-25 By Gnosis. Allright reserved.
* Time: ÏÂÎç2:25:49
*/
package com.chinasofti.day02.hierarchy;

public class Userinfo {
	private int id;
	private String username;
	private String password;
	private double account;
	private String email;

	public int getId() {
		return id;
	}

	public void setId(int id) {
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

	public double getAccount() {
		return account;
	}

	public void setAccount(double account) {
		this.account = account;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Userinfo() {
	}

	public Userinfo(int id, String username, String password, double account, String email) {
		super();
		this.id = id;
		this.username = username;
		this.password = password;
		this.account = account;
		this.email = email;
	}

	@Override
	public String toString() {
		return "Userinfo [id=" + id + ", username=" + username + ", password=" + password + ", account=" + account
				+ ", email=" + email + "]";
	}

}
