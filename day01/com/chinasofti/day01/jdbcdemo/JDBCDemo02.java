/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: JDBCDemo02.java
* Copyright 2017-08-24 By Gnosis. Allright reserved.
* Time: 下午5:00:17
*/
package com.chinasofti.day01.jdbcdemo;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class JDBCDemo02 {

	public static void main(String[] args) throws Exception {
		//查看每个员工的名字，职位，部门名称和工作所在地
		String sql = "select e.ename, e.job, d.dname, d.loc from emp e, dept d where e.deptno = d.deptno";
		String className = "oracle.jdbc.driver.OracleDriver";
		Class.forName(className);
		Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "gnosis", "123456");
		PreparedStatement pstm = conn.prepareStatement(sql);
		ResultSet rs = pstm.executeQuery();
		while(rs.next()){
			for (int i = 1; i <= JDBCDemo01.countColumn(rs); ++i) {
				System.out.print(rs.getString(i) + "  ");
			}
			System.out.println();
		}
		rs.close();
		pstm.close();
		conn.close();
	}

}
