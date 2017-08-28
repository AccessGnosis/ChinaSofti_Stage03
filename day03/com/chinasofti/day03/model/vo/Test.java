/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: Test.java
* Copyright 2017-08-28 By Gnosis. Allright reserved.
* Time: 上午9:07:34
*/
package com.chinasofti.day03.model.vo;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class Test {

	public static void main(String[] args) {
		/*
		User user = new User("10001", "张三", "123", 20);
		
		User newUser = (User) copyUesr(user);
		System.out.println(user.equals(newUser));
		System.out.println(user == newUser);
		*/
		User user = new User("10001", "张三", "123", 20);
		User newUser = (User) copyObject(user);
		System.out.println("==========================================");
		System.out.println(user.equals(newUser));
		System.out.println(user == newUser);
	}

	// 实现对象的拷贝
	public static Object copyUesr(User user) {
		User newUser = null;
		newUser = new User();
		newUser.setId(user.getId());
		newUser.setUsername(user.getUsername());
		newUser.setPassword(user.getPassword());
		newUser.setAge(user.getAge());

		return newUser;
	}

	// 使用反射实现对所有vo对象的拷贝
	public static Object copyObject(Object obj) {
		Object object = null;

		// 获得obj的类型对象
		Class clazz = obj.getClass();
		System.out.println(clazz.getName());

		try {
			object = clazz.newInstance();
			System.out.println(object);
			Field fields[] = clazz.getDeclaredFields();

			for (int i = 0; i < fields.length; ++i) {
				// 获得属性的名字
				System.out.println(fields[i].getName());
				// 获得属性的类型
				System.out.println(fields[i].getType());

				// 获得属性的值
				// 判断该属性的类型为int类型
				if (fields[i].getType() == int.class) {
					System.out.println(fields[i].getInt(obj));
				}
			}

			// 动态的调用方法
			System.out.println("----------------------------------");
			Method methods[] = clazz.getDeclaredMethods();

			for (int i = 0; i < methods.length; ++i) {
				// 获得方法的名字
				System.out.println(methods[i].getName());
				// 获得方法的返回值类型
				System.out.println(methods[i].getReturnType());
				// 获得方法的返回值类型
			}
			// 通过名字来拿到某一个方法
			// class对象中的getMethod方法有两个参数
			// 第一个参数为方法的名字
			// 第二个参数为方法的参数列表的类型
			Method method = clazz.getMethod("getUsername", null);
			System.out.println(method.getName());
			// 调用该方法
			System.out.println(method.invoke(obj, null));

			System.out.println("=============================================");
			String[] getMethodNames = new String[fields.length];
			String[] setMethodNames = new String[fields.length];

			for (int i = 0; i < fields.length; ++i) {
				getMethodNames[i] = "get" + fields[i].getName().substring(0, 1).toUpperCase()
						+ fields[i].getName().substring(1);
				// System.out.println(getMethodNames[i]);
				setMethodNames[i] = "set" + fields[i].getName().substring(0, 1).toUpperCase()
						+ fields[i].getName().substring(1);
			}

			for (int i = 0; i < fields.length; ++i) {
				System.out.println(setMethodNames[i] + "\t" + getMethodNames[i]);
			}

			Object tempObject = null;

			for (int i = 0; i < fields.length; ++i) {
				for (int j = 0; j < methods.length; ++j) {
					if (methods[j].getName().equals(getMethodNames[i])) {
						// 调用get方法 并获得返回值
						tempObject = methods[j].invoke(obj, null);
					}
					// 此处不能确定get和set的位置，所以需要重新循环
				}
				for (int j = 0; j < methods.length; ++j) {
					if (methods[j].getName().equals(setMethodNames[i])) {
						methods[j].invoke(object, tempObject);
					}
				}

			}
		} catch (InstantiationException | IllegalAccessException | NoSuchMethodException | IllegalArgumentException
				| InvocationTargetException e) {
			e.printStackTrace();
		}

		return object;
	}
}
