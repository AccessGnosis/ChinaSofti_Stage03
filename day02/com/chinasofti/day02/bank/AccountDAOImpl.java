/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: AccountDAOImpl.java
* Copyright 2017-08-25 By Gnosis. Allright reserved.
* Time: ÏÂÎç3:49:13
*/
package com.chinasofti.day02.bank;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AccountDAOImpl implements IAccountDAO {

	@Override
	public boolean insert(String name, double balance) {
		boolean tag = false;

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = DBUtil.getConnection();
			con.setAutoCommit(false);
			String sql = "insert into tb_userinfo(name, balance) values(?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, name);
			pstmt.setDouble(2, balance);
			int i = pstmt.executeUpdate();

			if (i == 1) {
				tag = true;
				con.commit();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(pstmt, con);
		}

		return tag;
	}

	@Override
	public boolean transform(String from, String to, double money) {
		boolean tag = false;
		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt1 = null;
		try {
			String sql = "update tb_userinfo set balance=balance-? where name=?";
			con = DBUtil.getConnection();
			pstmt = con.prepareStatement(sql);
			con.setAutoCommit(false);
			pstmt.setDouble(1, money);
			pstmt.setString(2, from);
			int i = pstmt.executeUpdate();

			String sql1 = "update tb_userinfo set balance=balance+? where name=?";
			pstmt1 = con.prepareStatement(sql1);
			pstmt1.setDouble(1, money);
			pstmt1.setString(2, to);
			int i1 = pstmt1.executeUpdate();

			// if (true) {
			// throw new Exception();
			// }

			if (i == 1 && i1 == 1) {
				tag = true;
				con.commit();
			} else {
				con.rollback();
			}

		} catch (Exception e) {
			try {
				con.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			DBUtil.close(pstmt, con);
		}

		return tag;
	}

	public void createDB() {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = DBUtil.getConnection();
			String sql = "create table tb_userinfo(" + "name varchar2(30)," + "balance number(20,2))";
			pstmt = con.prepareStatement(sql);
			pstmt.execute();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(pstmt, con);
		}
	}

}
