/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: MainClass.java
* Copyright 2017-08-24 By Gnosis. Allright reserved.
* Time: ����5:44:05
*/
package com.chinasofti.day01.task;

import java.util.Scanner;

public class MainClass {

	public static void main(String[] args) {
		System.out.println("==============================================");
		System.out.println("====================��ӭʹ��ϵͳ==================");
		System.out.println("==============================================");

		System.out.println("1.ע��");
		System.out.println("2.��¼");
		System.out.println("3.��ʾ���ݱ�����Ա��");
		System.out.println("4.�޸�Ա��������Ա��");
		System.out.println("5.ɾ��Ա��������Ա��");
		System.out.println("6.�������ݱ�����Ա��");
		System.out.println("7.ɾ�����ݱ�����Ա��");
		System.out.println("0.�˳�");
		System.out.print("��ѡ���ܣ�");

		int command = -1;
		do {
			command = new Scanner(System.in).nextInt();
			if (command > 7 || command < 0) {
				System.out.print("�������ָ���������������룺");
			}
		} while (command > 7 || command < 0);

		UserDAO userdao = new UserDAO();

		switch (command) {
		case 1:
			if (userdao.reg()) {
				System.out.println("ע��ɹ�");
			} else {
				System.out.println("ע��ʧ��");
			}
			break;
		case 2:
			System.out.print("�������û�����");
			String username = new Scanner(System.in).nextLine();
			System.out.print("���������룺");
			String password = new Scanner(System.in).nextLine();
			if (userdao.login(username, password)) {
				userdao.selectInfo(username);
			} else {
				System.out.println("��¼ʧ��");
			}
			break;
		case 3:
			int page = -1;
			int pageSize = -1;
			do {
				System.out.print("������ҳ����(��0Ĭ��������м�¼)");
				page = new Scanner(System.in).nextInt();
				System.out.print("������ҳ������(��0Ĭ��������м�¼)");
				pageSize = new Scanner(System.in).nextInt();
				if (page > 0 || pageSize > 0) {
					userdao.selectDataByPage(page, pageSize);
				} else {
					userdao.select();
				}
			} while (page >= 0 || pageSize >= 0);
			break;
		case 4:
			System.out.print("������Ա��ID���£�");
			String id = new Scanner(System.in).nextLine();
			if (userdao.update(id)) {
				System.out.println("���³ɹ�");
			} else {
				System.out.println("����ʧ��");
			}
			break;
		case 5:
			System.out.print("������Ա��IDɾ����");
			String id2 = new Scanner(System.in).nextLine();
			if (userdao.delete(id2)) {
				System.out.println("ɾ���ɹ�");
			} else {
				System.out.println("ɾ��ʧ��");
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
