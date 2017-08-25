/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: JDBCDemo03.java
* Copyright 2017-08-24 By Gnosis. Allright reserved.
* Time: ÏÂÎç5:23:40
*/
package com.chinasofti.day01.jdbcdemo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class JDBCDemo03 {

	public static void main(String[] args) throws Exception {
		String sql = "create table empp("
				+ "id number(2),"
				+ "name varchar2(20)"
				+ ")";
//		String sql = "drop table empp";
		String className = "oracle.jdbc.driver.OracleDriver";
		Class.forName(className);
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "gnosis", "123456");
//		PreparedStatement pstm = conn.prepareStatement(sql);
		Statement stm = conn.createStatement();
		boolean state = stm.execute(sql);
		System.out.println(state);
		stm.close();
		conn.close();
	}

}
