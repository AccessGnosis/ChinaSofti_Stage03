/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: Test.java
* Copyright 2017-08-28 By Gnosis. Allright reserved.
* Time: ����9:07:34
*/
package com.chinasofti.day03.model.vo;

public class Test {

	public static void main(String[] args) {
		User user = new User("10001", "����", "123", 20);

		User newUser = (User) copyUesr(user);
		System.out.println(user.equals(newUser));
		System.out.println(user == newUser);
	}

	// ʵ�ֶ���Ŀ���
	public static Object copyUesr(User user) {
		User newUser = null;
		newUser = new User();
		newUser.setId(user.getId());
		newUser.setUsername(user.getUsername());
		newUser.setPassword(user.getPassword());
		newUser.setAge(user.getAge());

		return newUser;
	}
	
	//ʹ�÷���ʵ�ֶ�����vo����Ŀ���
	
}
