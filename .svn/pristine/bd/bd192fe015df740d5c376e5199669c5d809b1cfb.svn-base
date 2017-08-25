/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: DBUtil.java
* Copyright 2017-08-25 By Gnosis. Allright reserved.
* Time: 上午9:32:12
*/
package com.chinasofti.day02.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
	private static Connection getConnection() {
		// 1.加载驱动
		String className = "oracle.jdbc.driver.OracleDriver";
		Connection conn = null;
		try {
			Class.forName(className);
			// 2.连接数据库
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String user = "gnosis";
			String password = "123456";
			conn = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
}
