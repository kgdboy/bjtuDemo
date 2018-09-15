package bjtu.gruop7.util;

import java.util.ArrayList;

import bjtu.gruop7.util.SqlHelper;

public class Log {
	private SqlHelper sqlHelper;
	private String name;
	private String orga_id;
	private String depart_id;
	
	public Log(String salary_number, String log_category,String msg) {
		sqlHelper=new SqlHelper();
		String sql="select name,orga_id,depart_id from info_user where salary_number=?";
		ArrayList<String[]> arr = sqlHelper.executeQuery(sql, new String[]{salary_number});
		if(arr.size()>0){
			name=arr.get(0)[0];
			orga_id=arr.get(0)[1];
			depart_id=arr.get(0)[2];
		}
		String sql2="INSERT ignore INTO log(log_category,salary_number,orga_id,depart_id,name,log_content) VALUES (?,?,?,?,?,?)";
		sqlHelper.executeUpdate(sql2,new String[]{log_category,salary_number,orga_id,depart_id,name,msg});
	}
}
