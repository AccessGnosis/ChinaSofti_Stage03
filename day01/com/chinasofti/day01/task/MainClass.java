/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: MainClass.java
* Copyright 2017-08-24 By Gnosis. Allright reserved.
* Time: 下午5:44:05
*/
package com.chinasofti.day01.task;

import java.util.Scanner;

public class MainClass {

	public static void main(String[] args) {
		System.out.println("==============================================");
		System.out.println("====================欢迎使用系统==================");
		System.out.println("==============================================");

		System.out.println("1.注册");
		System.out.println("2.登录");
		System.out.println("3.显示数据表（管理员）");
		System.out.println("4.修改员工（管理员）");
		System.out.println("5.删除员工（管理员）");
		System.out.println("6.创建数据表（管理员）");
		System.out.println("7.删除数据表（管理员）");
		System.out.println("0.退出");
		System.out.print("请选择功能：");

		int command = -1;
		do {
			command = new Scanner(System.in).nextInt();
			if (command > 7 || command < 0) {
				System.out.print("您输入的指令有误，请重新输入：");
			}
		} while (command > 7 || command < 0);

		UserDAO userdao = new UserDAO();

		switch (command) {
		case 1:
			if (userdao.reg()) {
				System.out.println("注册成功");
			} else {
				System.out.println("注册失败");
			}
			break;
		case 2:
			System.out.print("请输入用户名：");
			String username = new Scanner(System.in).nextLine();
			System.out.print("请输入密码：");
			String password = new Scanner(System.in).nextLine();
			if (userdao.login(username, password)) {
				userdao.selectInfo(username);
			} else {
				System.out.println("登录失败");
			}
			break;
		case 3:
			int page = -1;
			int pageSize = -1;
			do {
				System.out.print("请输入页数：(输0默认输出所有记录)");
				page = new Scanner(System.in).nextInt();
				System.out.print("请输入页容量：(输0默认输出所有记录)");
				pageSize = new Scanner(System.in).nextInt();
				if (page > 0 || pageSize > 0) {
					userdao.selectDataByPage(page, pageSize);
				} else {
					userdao.select();
				}
			} while (page >= 0 || pageSize >= 0);
			break;
		case 4:
			System.out.print("请输入员工ID更新：");
			String id = new Scanner(System.in).nextLine();
			if (userdao.update(id)) {
				System.out.println("更新成功");
			} else {
				System.out.println("更新失败");
			}
			break;
		case 5:
			System.out.print("请输入员工ID删除：");
			String id2 = new Scanner(System.in).nextLine();
			if (userdao.delete(id2)) {
				System.out.println("删除成功");
			} else {
				System.out.println("删除失败");
			}
			break;
		case 6:
			DDLProcess.createTable();
			break;
		case 7:
			DDLProcess.dropTable();
			break;
		}

	}

}
