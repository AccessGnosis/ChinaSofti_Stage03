/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: DBUtil02.java
* Copyright 2017-08-25 By Gnosis. Allright reserved.
* Time: 上午11:03:25
*/
package com.chinasofti.day02.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Properties;
import java.util.UUID;

import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSourceFactory;

public class DBUtil02 {

	public static void main(String[] args) throws Exception {
		Connection con = getConnection();
		System.out.println(con);
		String sql = "insert into userinfo values(?, ?, ?, ?, ?)";
		PreparedStatement pstm = null;

		pstm = con.prepareStatement(sql);
		for (int i = 0; i < 10000; ++i) {
			pstm.setString(1, UUID.randomUUID().toString().replaceAll("-", ""));
			pstm.setString(2, "gnosis" + UUID.randomUUID().toString().substring(0, 4));
			pstm.setString(3, "123");
			pstm.setString(4, "gaojing1996@vip.qq.com");
			pstm.setDouble(5, Math.random() * 10000);
			pstm.addBatch();
		}
		int[] arr = pstm.executeBatch();

		for (int a : arr) {
			System.out.print(a + " ");
		}

		pstm.close();
		con.close();
	}

	public static Connection getConnection() throws Exception {
		// 加载prop配置文件
		Properties prop = new Properties();
		// 获取文件流
		InputStream inStream = DBUtil02.class.getResourceAsStream("db.properties");
		// 加载属性配置文件
		prop.load(inStream);
		// 根据prop配置，直接创建数据源对象
		DataSource dataSouce = BasicDataSourceFactory.createDataSource(prop);

		// 获取连接
		Connection con = dataSouce.getConnection();

		return con;
	}
}
