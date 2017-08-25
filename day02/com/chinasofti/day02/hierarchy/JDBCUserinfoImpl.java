/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: JDBCUserinfoImpl.java
* Copyright 2017-08-25 By Gnosis. Allright reserved.
* Time: ÏÂÎç2:35:27
*/
package com.chinasofti.day02.hierarchy;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.chinasofti.day01.task.User;

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
			System.out.println("±£´æÊ§°Ü");
			e.printStackTrace();
		} finally {
			DBUtil.close(conn);
		}
		return false;
	}

	@Override
	public boolean update(Userinfo userinfo) {
		Connection conn = null;
		PreparedStatement pstm = null;

		try {
			conn = DBUtil.getConnection();
			String sql = "update userinfo set name=?, password=?, account=?, email=? where id=?";
			pstm = conn.prepareStatement(sql);

			pstm.setString(1, userinfo.getUsername());
			pstm.setString(2, userinfo.getPassword());
			pstm.setDouble(3, userinfo.getAccount());
			pstm.setString(4, userinfo.getEmail());
			pstm.setInt(5, userinfo.getId());

			if (pstm.executeUpdate() > 0) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(pstm, conn);
		}
		return false;
	}

	@Override
	public List<Userinfo> findAll() {
		List<Userinfo> users = new ArrayList<Userinfo>();
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;

		try {
			conn = DBUtil.getConnection();
			String sql = "select * from userinfo";
			pstm = conn.prepareStatement(sql);
			rs = pstm.executeQuery();

			while (rs.next()) {
				Userinfo user = new Userinfo();
				user.setId(rs.getInt("id"));
				user.setUsername(rs.getString("name"));
				user.setPassword(rs.getString("password"));
				user.setAccount(rs.getDouble("account"));
				user.setEmail(rs.getString("email"));
				users.add(user);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs, pstm, conn);
		}

		return users;
	}

	@Override
	public Userinfo findById(int id) {
		Userinfo user = new Userinfo();
		Connection conn = null;
		PreparedStatement pstm = null;
		ResultSet rs = null;

		try {
			conn = DBUtil.getConnection();
			String sql = "select * from userinfo where id=?";
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, id);
			rs = pstm.executeQuery();

			while (rs.next()) {
				user.setId(rs.getInt("id"));
				user.setUsername(rs.getString("name"));
				user.setPassword(rs.getString("password"));
				user.setAccount(rs.getDouble("account"));
				user.setEmail(rs.getString("email"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(rs, pstm, conn);
		}

		return user;
	}

	@Override
	public boolean deleteById(int id) {
		Connection conn = null;
		PreparedStatement pstm = null;

		try {
			conn = DBUtil.getConnection();
			String sql = "delete from userinfo where id=?";
			pstm = conn.prepareStatement(sql);
			pstm.setInt(1, id);

			if (pstm.executeUpdate() > 0) {
				return true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBUtil.close(pstm, conn);
		}

		return false;
	}

}
