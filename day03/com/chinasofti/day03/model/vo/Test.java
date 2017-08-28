/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: Test.java
* Copyright 2017-08-28 By Gnosis. Allright reserved.
* Time: ����9:07:34
*/
package com.chinasofti.day03.model.vo;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

public class Test {

	public static void main(String[] args) {
		/*
		User user = new User("10001", "����", "123", 20);
		
		User newUser = (User) copyUesr(user);
		System.out.println(user.equals(newUser));
		System.out.println(user == newUser);
		*/
		User user = new User("10001", "����", "123", 20);
		User newUser = (User) copyObject(user);
		System.out.println("==========================================");
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

	// ʹ�÷���ʵ�ֶ�����vo����Ŀ���
	public static Object copyObject(Object obj) {
		Object object = null;

		// ���obj�����Ͷ���
		Class clazz = obj.getClass();
		System.out.println(clazz.getName());

		try {
			object = clazz.newInstance();
			System.out.println(object);
			Field fields[] = clazz.getDeclaredFields();

			for (int i = 0; i < fields.length; ++i) {
				// ������Ե�����
				System.out.println(fields[i].getName());
				// ������Ե�����
				System.out.println(fields[i].getType());

				// ������Ե�ֵ
				// �жϸ����Ե�����Ϊint����
				if (fields[i].getType() == int.class) {
					System.out.println(fields[i].getInt(obj));
				}
			}

			// ��̬�ĵ��÷���
			System.out.println("----------------------------------");
			Method methods[] = clazz.getDeclaredMethods();

			for (int i = 0; i < methods.length; ++i) {
				// ��÷���������
				System.out.println(methods[i].getName());
				// ��÷����ķ���ֵ����
				System.out.println(methods[i].getReturnType());
				// ��÷����ķ���ֵ����
			}
			// ͨ���������õ�ĳһ������
			// class�����е�getMethod��������������
			// ��һ������Ϊ����������
			// �ڶ�������Ϊ�����Ĳ����б������
			Method method = clazz.getMethod("getUsername", null);
			System.out.println(method.getName());
			// ���ø÷���
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
						// ����get���� ����÷���ֵ
						tempObject = methods[j].invoke(obj, null);
					}
					// �˴�����ȷ��get��set��λ�ã�������Ҫ����ѭ��
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
