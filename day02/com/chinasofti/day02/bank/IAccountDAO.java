/**
* Describe: 
* Keyword: 
* Hint: 
* Filename: IAccountDAO.java
* Copyright 2017-08-25 By Gnosis. Allright reserved.
* Time: обнГ3:48:57
*/
package com.chinasofti.day02.bank;

public interface IAccountDAO {
	public boolean insert(String name, double balance);
	
	public boolean transform(String from, String to, double money);
}
