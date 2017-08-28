/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: Test01.java
* Copyright 2017-08-28 By Gnosis. Allright reserved.
* Time: 上午10:21:13
*/
package com.chinasofti.day03.model.test;

import com.chinasofti.day03.model.vo.User;

public class Test01 {

	public static void main(String[] args) {
		try {
			Class clazz = Class.forName("com.chinasofti.day03.model.vo.User");
			System.out.println(clazz.getName());
			System.out.println(clazz);
			Class clazz1 = new User().getClass();
			System.out.println(clazz1.getName());
			// clazz和clazz1是同一个对象
			// 同一个类加载器加载（每一个类只提供一个类加载器）
			System.out.println(clazz == clazz1);
			
			Class clazz2 = User.class;
			System.out.println(clazz == clazz2);
			
//			System.out.println(int.class);
//			System.out.println(Integer.class);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

}
