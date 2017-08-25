/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: JDBCDemo01.java
* Copyright 2017-08-24 By Gnosis. Allright reserved.
* Time: ����3:13:55
*/
package com.chinasofti.day01.jdbcdemo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import jdk.internal.dynalink.support.ClassMap;

/*
 * ʹ��JDBC�������ݿ�Ĳ��裺
 * 	1.�����������������ӣ�
 * 	2.����������
 * 	3.ִ��SQL���
 * 	4.��������
 * 	5.�ر�����
 */
public class JDBCDemo01 {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// 1. ʹ��class����
		Class<java.util.Date> dateclass1 = java.util.Date.class;
		// 2. ʹ�ö����getClass()����
		java.util.Date date = new java.util.Date();
		Class<? extends Date> dateclass2 = date.getClass();
		// 3. ͨ��Class��ȥ���þ�̬����forName()
		Class<?> dateclass3 = Class.forName("java.util.Date");

		// 1.��������
		Class.forName("oracle.jdbc.driver.OracleDriver");
		System.out.println("�����������");
		// 2.�������ݿ⣬ͨ��DriverManager�������������ݿ������
		Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@192.168.80.41:1521:xe", "gnosis", "123456");
		System.out.println("���ݿ�������");
		// 3.����SQL������ִ��
		String sql = "select * from emp";
		PreparedStatement pstm = connection.prepareStatement(sql);
		ResultSet query = pstm.executeQuery();
		/*
		 * Statement��Բ�ͬ��SQL����ṩ�˲�ͬ��ִ�з�����
		 * ResultSet executeQuery(String sql);
		 * �÷���ר������ִ��DQL��䷵�ص�ResultSet��ʾ��ѯ�����Ľ����
		 * 
		 * int executeUpdate(String sql);
		 * �÷���ר������ִ��DML���������ص����ֱ�ʾִ�и�����Ӱ���˶���������
		 * 
		 * boolean execute(String sql)
		 * �����������ʲô��䶼����ִ�У���������DQL��DML����ר�Ÿ���ķ���
		 * ���ԣ���ʱ��execute()����ͨ��ֻ����ִ��DDL���
		 * �÷���ִ��DDL��䣬����true�����ִ�е���������䣬����false
		 */
		/*
		 * ResultSet�ṩ�����ڱ���������ķ���
		 * Boolean next();
		 * getXXX();
		 */
		while (query.next()) {
			for (int i = 1; i <= countColumn(query); ++i) {
				System.out.print(query.getString(i) + "\t");
			}
			System.out.println();
		}
		query.close();
		pstm.close();
		connection.close();
	}

	public static int countColumn(ResultSet rs) {
		int count = 0;

		while (true) {
			try {
				rs.getString(++count);
			} catch (SQLException e) {
				break;
			}
		}
		return count - 1;
	}
}
