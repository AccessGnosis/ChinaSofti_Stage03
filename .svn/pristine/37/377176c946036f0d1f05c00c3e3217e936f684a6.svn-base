/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: JDBCUtil.java
* Copyright 2017-08-24 By Gnosis. Allright reserved.
* Time: ÏÂÎç5:52:29
*/
package com.chinasofti.day01.task;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JDBCUtil {
	private static JDBCUtil instance = null;
	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	private JDBCUtil() {
	}

	public static JDBCUtil getInstance() {
		if (instance == null) {
			synchronized (JDBCUtil.class) {
				if (instance == null) {
					instance = new JDBCUtil();
				}
			}
		}
		return instance;
	}

	Connection getConnection() {
		Connection conn = null;
		try {
			conn = DriverManager.getConnection("jdbc:oracle:thin:@192.168.80.41:1521:xe", "gnosis", "123456");
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return conn;
	}

	boolean close(ResultSet rs, PreparedStatement pstm, Connection conn) {
		int count = 0;
		if (rs != null) {
			try {
				rs.close();
				++count;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (pstm != null) {
			try {
				pstm.close();
				++count;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
				++count;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		if (count == 3)
			return true;
		else
			return false;
	}

	boolean close(PreparedStatement pstm, Connection conn) {
		int count = 0;
		if (pstm != null) {
			try {
				pstm.close();
				++count;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
				++count;
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		if (count == 2)
			return true;
		else
			return false;
	}

	public int countColumn(ResultSet rs) {
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
