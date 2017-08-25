/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: UserinfoDAO.java
* Copyright 2017-08-25 By Gnosis. Allright reserved.
* Time: ����2:29:51
*/
package com.chinasofti.day02.hierarchy;

import java.util.List;

public interface IUserinfoDAO {
	// �������
	boolean save(Userinfo userinfo);

	// �޸Ķ���
	boolean update(Userinfo userinfo);

	// ��ѯ���ж���
	List<Userinfo> findAll();

	// ͨ��id��ѯһ������
	Userinfo findById(int id);

	// ͨ��idɾ������
	boolean deleteById(int id);
}
