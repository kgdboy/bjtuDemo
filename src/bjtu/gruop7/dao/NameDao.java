package bjtu.gruop7.dao;

import java.util.ArrayList;

public class NameDao {

	public static String returnName(String id) {
		bjtu.gruop7.util.SqlHelper sqlHelper = new bjtu.gruop7.util.SqlHelper();
		String[] str = { id };
		String namestr="";
		ArrayList<String[]> arrayList = sqlHelper.executeQuery("select distinct name,salary_number from info_user"
				+ " where orga_id = ? " ,str);
		
		if (arrayList.size() > 0) {
			 for (int i = 0; i < arrayList.size(); i++) {
				 namestr=namestr.concat(arrayList.get(i)[0]+"-"+(arrayList.get(i)[1])+",");
			 }
		}
		//返回去掉最后逗号的字符串
		namestr = namestr.substring(0,namestr.length()-1);
		
		return namestr;
	}
	

}
