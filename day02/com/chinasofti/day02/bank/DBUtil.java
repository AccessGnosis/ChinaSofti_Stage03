/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: DBUtil02.java
* Copyright 2017-08-25 By Gnosis. Allright reserved.
* Time: ����11:03:25
*/
package com.chinasofti.day02.bank;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.UUID;

import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSourceFactory;

public class DBUtil {

	public static Connection getConnection() throws Exception {
		// ����prop�����ļ�
		Properties prop = new Properties();
		// ��ȡ�ļ���
		InputStream inStream = DBUtil.class.getResourceAsStream("db.properties");
		// �������������ļ�
		prop.load(inStream);
		// ����prop���ã�ֱ�Ӵ�������Դ����
		DataSource dataSouce = BasicDataSourceFactory.createDataSource(prop);

		// ��ȡ����
		Connection con = dataSouce.getConnection();

		return con;
	}

	public static void close(Connection conn) {
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	static boolean close(ResultSet rs, PreparedStatement pstm, Connection conn) {
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

	static boolean close(PreparedStatement pstm, Connection conn) {
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
}
