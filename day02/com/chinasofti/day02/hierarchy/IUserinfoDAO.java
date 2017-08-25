/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: UserinfoDAO.java
* Copyright 2017-08-25 By Gnosis. Allright reserved.
* Time: 下午2:29:51
*/
package com.chinasofti.day02.hierarchy;

import java.util.List;

public interface IUserinfoDAO {
	// 保存对象
	boolean save(Userinfo userinfo);

	// 修改对象
	boolean update(Userinfo userinfo);

	// 查询所有对象
	List<Userinfo> findAll();

	// 通过id查询一个对象
	Userinfo findById(int id);

	// 通过id删除对象
	boolean deleteById(int id);
}
