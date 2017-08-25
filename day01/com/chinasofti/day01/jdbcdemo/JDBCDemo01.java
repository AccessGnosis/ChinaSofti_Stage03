/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: JDBCDemo01.java
* Copyright 2017-08-24 By Gnosis. Allright reserved.
* Time: 下午3:13:55
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
 * 使用JDBC连接数据库的步骤：
 * 	1.加载驱动，建立连接；
 * 	2.创建语句对象；
 * 	3.执行SQL语句
 * 	4.处理结果集
 * 	5.关闭连接
 */
public class JDBCDemo01 {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		// 1. 使用class属性
		Class<java.util.Date> dateclass1 = java.util.Date.class;
		// 2. 使用对象的getClass()方法
		java.util.Date date = new java.util.Date();
		Class<? extends Date> dateclass2 = date.getClass();
		// 3. 通过Class类去调用静态方法forName()
		Class<?> dateclass3 = Class.forName("java.util.Date");

		// 1.加载驱动
		Class.forName("oracle.jdbc.driver.OracleDriver");
		System.out.println("加载驱动完毕");
		// 2.连接数据库，通过DriverManager驱动管理建立数据库的连接
		Connection connection = DriverManager.getConnection("jdbc:oracle:thin:@192.168.80.41:1521:xe", "gnosis", "123456");
		System.out.println("数据库已连接");
		// 3.创建SQL语句对象并执行
		String sql = "select * from emp";
		PreparedStatement pstm = connection.prepareStatement(sql);
		ResultSet query = pstm.executeQuery();
		/*
		 * Statement针对不同的SQL语句提供了不同的执行方法：
		 * ResultSet executeQuery(String sql);
		 * 该方法专门用来执行DQL语句返回的ResultSet表示查询出来的结果集
		 * 
		 * int executeUpdate(String sql);
		 * 该方法专门用来执行DML操作，返回的数字表示执行该语句后影响了多少条数据
		 * 
		 * boolean execute(String sql)
		 * 该语句理论上什么语句都可以执行，但是由于DQL和DML都有专门负责的方法
		 * 所以，此时，execute()方法通常只用来执行DDL语句
		 * 该方法执行DDL语句，返回true，如果执行的是其他语句，返回false
		 */
		/*
		 * ResultSet提供了用于遍历结果集的方法
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
