/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: DDLProcess.java
* Copyright 2017-08-24 By Gnosis. Allright reserved.
* Time: ÏÂÎç6:20:18
*/
package com.chinasofti.day01.task;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DDLProcess {
	public static boolean createTable() {
		boolean tag = false;
		JDBCUtil util = JDBCUtil.getInstance();
		Connection conn = util.getConnection();
		String sql = "create table userinfo(" + "id varchar2(40) primary key," + "username varchar2(20) not null,"
				+ "password varchar2(20) not null," + "email varchar2(40)," + "salary number(7,2) not null)";
		PreparedStatement pstm = null;

		try {
			pstm = conn.prepareStatement(sql);
			pstm.execute();
			tag = true;
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			util.close(pstm, conn);
		}

		return tag;
	}

	public static boolean dropTable() {
		boolean tag = false;
		JDBCUtil util = JDBCUtil.getInstance();
		Connection conn = util.getConnection();

		String sql = "drop table userinfo";
		PreparedStatement pstm = null;
		try {
			pstm = conn.prepareStatement(sql);
			pstm.execute();
			tag = true;
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			util.close(pstm, conn);
		}

		return tag;
	}
}
