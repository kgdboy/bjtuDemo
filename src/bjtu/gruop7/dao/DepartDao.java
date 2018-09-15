package bjtu.gruop7.dao;

import java.util.ArrayList;

public class DepartDao {

	public static String returnDepartName(String id) {
		bjtu.gruop7.util.SqlHelper sqlHelper = new bjtu.gruop7.util.SqlHelper();
		String[] str = { id };
		String bmstr="";
		ArrayList<String[]> arrayList = sqlHelper.executeQuery("select depart_name from info_department"
				+ " where orga_id = ? " ,str);
		
		if (arrayList.size() > 0) {
			 for (int i = 0; i < arrayList.size(); i++) {
				  bmstr=bmstr.concat(arrayList.get(i)[0]+",");
			 }
		}
		//返回去掉最后逗号的字符串
		bmstr = bmstr.substring(0,bmstr.length()-1);
		
		return bmstr;
	}
	
	
}
