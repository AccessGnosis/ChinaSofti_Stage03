/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: UserinfoService.java
* Copyright 2017-08-25 By Gnosis. Allright reserved.
* Time: ÏÂÎç2:49:32
*/
package com.chinasofti.day02.hierarchy;

import java.util.List;
import java.util.UUID;

public class UserinfoService {

	public static void main(String[] args) {
		// for (int i = 0; i < 1000; ++i)
		// reg();
		// findAll();
		// update();
		// findById();
		// deleteById();
	}

	private static void deleteById() {
		if (new JDBCUserinfoImpl().deleteById(109)) {
			System.out.println("É¾³ý³É¹¦");
		} else {
			System.out.println("É¾³ýÊ§°Ü");
		}
	}

	private static void findById() {
		Userinfo user = new JDBCUserinfoImpl().findById(101);
		System.out.println(user);
	}

	private static void update() {
		Userinfo user = new Userinfo(101, UUID.randomUUID().toString().substring(0, 6), "123456", Math.random() * 10000,
				UUID.randomUUID().toString().substring(0, 6) + "@qq.com");
		if (new JDBCUserinfoImpl().update(user)) {
			System.out.println("ÐÞ¸Ä³É¹¦");
		} else {
			System.out.println("ÐÞ¸ÄÊ§°Ü");
		}
	}

	private static void findAll() {
		IUserinfoDAO dao = new JDBCUserinfoImpl();

		List<Userinfo> users = dao.findAll();
		for (Userinfo u : users) {
			System.out.println(u);
		}
	}

	private static void reg() {
		Userinfo user = new Userinfo(0, UUID.randomUUID().toString().substring(0, 6), "123456", Math.random() * 10000,
				UUID.randomUUID().toString().substring(0, 6) + "@qq.com");

		IUserinfoDAO dao = new JDBCUserinfoImpl();
		boolean flag = dao.save(user);
		if (flag) {
			System.out.println("×¢²á³É¹¦");
		} else {
			System.out.println("×¢²áÊ§°Ü");
		}
	}

}
