/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: JDBCDemo04.java
* Copyright 2017-08-24 By Gnosis. Allright reserved.
* Time: ÏÂÎç5:31:10
*/
package com.chinasofti.day01.jdbcdemo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class JDBCDemo04 {

	public static void main(String[] args) throws Exception {
		String sql = "insert into empp values(10, 'lisi')";
		String className = "oracle.jdbc.driver.OracleDriver";
		Class.forName(className);
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "gnosis", "123456");
		PreparedStatement pstm = conn.prepareStatement(sql);
		System.out.println(pstm.executeUpdate());
		pstm.close();
		conn.close();
	}

}
