/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: Test01.java
* Copyright 2017-08-28 By Gnosis. Allright reserved.
* Time: ����10:21:13
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
			// clazz��clazz1��ͬһ������
			// ͬһ������������أ�ÿһ����ֻ�ṩһ�����������
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
