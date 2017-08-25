/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: JDBCUserinfoImpl.java
* Copyright 2017-08-25 By Gnosis. Allright reserved.
* Time: œ¬ŒÁ2:35:27
*/
package com.chinasofti.day02.hierarchy;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;

public class JDBCUserinfoImpl implements IUserinfoDAO {

	@Override
	public boolean save(Userinfo userinfo) {
		Connection conn = null;
		PreparedStatement pstm = null;

		try {
			conn = DBUtil.getConnection();
			String sql = "insert into userinfo values(userinfo_seq.nextval, ?, ?, ?, ?)";
			pstm = conn.prepareStatement(sql);

			pstm.setString(1, userinfo.getUsername());
			pstm.setString(2, userinfo.getPassword());
			pstm.setDouble(3, userinfo.getAccount());
			pstm.setString(4, userinfo.getEmail());

			if (pstm.executeUpdate() > 0) {
				return true;
			}
		} catch (Exception e) {
			System.out.println("±£¥Ê ß∞‹");
			e.printStackTrace();
		}finally {
			DBUtil.close(conn);
		}
		return false;
	}

	@Override
	public boolean update(Userinfo userinfo) {
		return false;
	}

	@Override
	public List<Userinfo> findAll() {
		return null;
	}

	@Override
	public Userinfo findById(int id) {
		return null;
	}

	@Override
	public boolean deleteById(int id) {
		return false;
	}

}
