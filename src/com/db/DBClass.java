package com.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class DBClass {
	public Connection cn;
	Statement st;
	public void connect() throws ClassNotFoundException, SQLException
	{
		Class.forName("com.mysql.jdbc.Driver");
		cn=DriverManager.getConnection("jdbc:mysql://localhost/advertisement","root","turbo123");
		st=cn.createStatement();	
	}
	public void close() throws SQLException
	{
		cn.close();
	}
	public void execute(String sql,String ...args) throws Exception
	{
		connect();
		PreparedStatement ps=cn.prepareStatement(sql);
		for(int i=0;i<args.length;i++)
		{
			ps.setString(i+1,args[i]);
			
		}
		ps.executeUpdate();
		close();
		
	}
	
	public ResultSet getRows(String sql,String ...args) throws Exception
	{
		connect();
		PreparedStatement ps=cn.prepareStatement(sql);
		for(int i=0;i<args.length;i++)
		{
			ps.setString(i+1,args[i]);
			
		}
		ResultSet rs=ps.executeQuery();
		
		
		return rs;	
	}
	
	
	
}
