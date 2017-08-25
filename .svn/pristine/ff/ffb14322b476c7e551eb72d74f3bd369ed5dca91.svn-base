/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: UserDAO.java
* Copyright 2017-08-24 By Gnosis. Allright reserved.
* Time: 下午6:05:27
*/
package com.chinasofti.day01.task;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;
import java.util.UUID;

public class UserDAO {
	boolean reg() {
		boolean tag = false;
		Scanner scan = new Scanner(System.in);

		User user = new User();
		System.out.print("请输入用户名：");
		user.setUsername(scan.nextLine());
		System.out.print("请输入密码：");
		user.setPassword(scan.nextLine());
		System.out.print("请输入邮箱：");
		user.setEmail(scan.nextLine());
		System.out.print("请输入工资：");
		user.setSalary(scan.nextDouble());

		UUID uuid = UUID.randomUUID();
		user.setId(uuid.toString().replaceAll("-", ""));

		JDBCUtil util = JDBCUtil.getInstance();
		Connection conn = util.getConnection();
		String sql = "insert into userinfo values(?, ?, ?, ?, ?)";
		PreparedStatement pstm = null;

		try {
			pstm = conn.prepareStatement(sql);

			pstm.setString(1, user.getId());
			pstm.setString(2, user.getUsername());
			pstm.setString(3, user.getPassword());
			pstm.setString(4, user.getEmail());
			pstm.setDouble(5, user.getSalary());

			int count = pstm.executeUpdate();

			if (count == 1) {
				tag = true;
				conn.commit();
			} else {
				System.out.println("数据插入失败，正在回滚");
				conn.rollback();
			}
		} catch (SQLException e) {
			try {
				System.out.println("数据插入失败，正在回滚");
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			util.close(pstm, conn);
		}

		return tag;
	}

	boolean regtest() {
		boolean tag = false;
		Scanner scan = new Scanner(System.in);

		User user = new User();
		user.setUsername("gnosis" + UUID.randomUUID().toString().substring(0, 4));
		user.setPassword("123");
		user.setEmail("gaojing1996@vip.qq.com");
		user.setSalary(Math.random() * 10000);

		UUID uuid = UUID.randomUUID();
		user.setId(uuid.toString().replaceAll("-", ""));

		JDBCUtil util = JDBCUtil.getInstance();
		Connection conn = util.getConnection();
		String sql = "insert into userinfo values(?, ?, ?, ?, ?)";
		PreparedStatement pstm = null;

		try {
			pstm = conn.prepareStatement(sql);

			pstm.setString(1, user.getId());
			pstm.setString(2, user.getUsername());
			pstm.setString(3, user.getPassword());
			pstm.setString(4, user.getEmail());
			pstm.setDouble(5, user.getSalary());

			int count = pstm.executeUpdate();

			if (count == 1) {
				tag = true;
				conn.commit();
			} else {
				System.out.println("数据插入失败，正在回滚");
				conn.rollback();
			}
		} catch (SQLException e) {
			try {
				System.out.println("数据插入失败，正在回滚");
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			util.close(pstm, conn);
		}

		return tag;
	}

	boolean login(String username, String password) {
		boolean tag = false;

		JDBCUtil util = JDBCUtil.getInstance();
		Connection conn = util.getConnection();
		String sql = "select * from userinfo where username=? and password=?";

		PreparedStatement pstm = null;
		ResultSet rs = null;

		try {
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, username);
			pstm.setString(2, password);

			rs = pstm.executeQuery();
			if (rs.next()) {
				tag = true;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			util.close(rs, pstm, conn);
		}

		return tag;
	}

	void selectInfo(String username) {
		JDBCUtil util = JDBCUtil.getInstance();
		Connection conn = util.getConnection();
		String sql = "select * from userinfo where username=?";

		PreparedStatement pstm = null;
		ResultSet rs = null;

		try {
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, username);

			rs = pstm.executeQuery();

			while (rs.next()) {
				System.out.println("用户ID：\t" + rs.getString("id"));
				System.out.println("用户名：\t" + rs.getString("username"));
				System.out.println("密码：\t" + rs.getString("password"));
				System.out.println("邮箱：\t" + rs.getString("email"));
				System.out.println("薪水：\t" + rs.getDouble("salary"));
				System.out.println();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			util.close(rs, pstm, conn);
		}
	}

	void selectDataByPage(int page, int pageSize) {
		JDBCUtil util = JDBCUtil.getInstance();
		Connection conn = util.getConnection();
		String sql = "select * from(select rownum rown, t.* from(select * from userinfo order by salary desc) t) where rown between "
				+ ((page - 1) * pageSize + 1) + " and " + (page * pageSize);

		PreparedStatement pstm = null;
		ResultSet rs = null;

		try {
			pstm = conn.prepareStatement(sql);
			rs = pstm.executeQuery();

			while (rs.next()) {
				System.out.print(rs.getString(1) + "  ");
				System.out.print(rs.getString(2) + "  ");
				System.out.print(rs.getString(3) + "  ");
				System.out.print(rs.getString(4) + "  ");
				System.out.print(rs.getString(5) + "  ");
				System.out.print(rs.getDouble(6) + "  ");
				System.out.println();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			util.close(rs, pstm, conn);
		}
	}

	void select() {
		JDBCUtil util = JDBCUtil.getInstance();
		Connection conn = util.getConnection();
		String sql = "select * from userinfo order by salary desc";

		PreparedStatement pstm = null;
		ResultSet rs = null;

		try {
			pstm = conn.prepareStatement(sql);
			rs = pstm.executeQuery();

			while (rs.next()) {
				System.out.print(rs.getString(1) + "  ");
				System.out.print(rs.getString(2) + "  ");
				System.out.print(rs.getString(3) + "  ");
				System.out.print(rs.getString(4) + "  ");
				System.out.print(rs.getString(5) + "  ");
				System.out.println();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			util.close(rs, pstm, conn);
		}
	}

	boolean delete(String idoname) {
		boolean tag = false;

		JDBCUtil util = JDBCUtil.getInstance();
		Connection conn = util.getConnection();
		String sql = "delete from userinfo where id = ? or username = ?";

		PreparedStatement pstm = null;

		try {
			pstm = conn.prepareStatement(sql);
			pstm.setString(1, idoname);
			pstm.setString(2, idoname);

			int count = pstm.executeUpdate();

			if (count == 1) {
				tag = true;
				conn.commit();
			} else {
				System.out.println("有重名的数据存在，回滚数据操作，请按id进行删除");
				conn.rollback();
			}
		} catch (SQLException e) {
			System.out.println("删除用户错误,回滚数据操作");
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			util.close(pstm, conn);
		}

		return tag;
	}

	boolean update(String id) {
		boolean tag = false;

		JDBCUtil util = JDBCUtil.getInstance();
		Connection conn = util.getConnection();
		String sql = "update userinfo set username=?, password=?, email=?, salary=? where id=?";

		PreparedStatement pstm = null;
		Scanner scan = new Scanner(System.in);

		try {
			pstm = conn.prepareStatement(sql);
			System.out.print("请输入用户名：");
			pstm.setString(1, scan.nextLine());
			System.out.print("请输入密码：");
			pstm.setString(2, scan.nextLine());
			System.out.print("请输入邮箱：");
			pstm.setString(3, scan.nextLine());
			System.out.print("请输入工资：");
			pstm.setDouble(4, scan.nextDouble());
			pstm.setString(5, id);

			int count = pstm.executeUpdate();

			if (count == 1) {
				tag = true;
				conn.commit();
			} else {
				System.out.println("更新有误");
				conn.rollback();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			util.close(pstm, conn);
		}

		return tag;
	}

}
