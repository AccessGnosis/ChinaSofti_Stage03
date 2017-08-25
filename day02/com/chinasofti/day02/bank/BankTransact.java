/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: BankTransact.java
* Copyright 2017-08-25 By Gnosis. Allright reserved.
* Time: обнГ3:45:28
*/
package com.chinasofti.day02.bank;

public class BankTransact {

	public static void main(String[] args) {
		AccountDAOImpl dao = new AccountDAOImpl();
//		dao.createDB();
//		dao.insert("zhangsan", 1000);
//		dao.insert("lisi", 10);
		dao.transform("lisi", "zhangsan", 500);
	}

}
