/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: UserinfoService.java
* Copyright 2017-08-25 By Gnosis. Allright reserved.
* Time: ÏÂÎç2:49:32
*/
package com.chinasofti.day02.hierarchy;

public class UserinfoService {

	public static void main(String[] args) {
		Userinfo user = new Userinfo(0, "xiaolong", "123456", 250, "xiaolon@qq.com");

		IUserinfoDAO dao = new JDBCUserinfoImpl();
		boolean flag = dao.save(user);
		if (flag) {
			System.out.println("×¢²á³É¹¦");
		} else {
			System.out.println("×¢²áÊ§°Ü");
		}
	}

}
