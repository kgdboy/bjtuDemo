package bjtu.gruop7.dao;

import java.util.ArrayList;

public class NameDao {

	public static String returnName(String id,String name) {
		bjtu.gruop7.util.SqlHelper sqlHelper = new bjtu.gruop7.util.SqlHelper();
		String[] str = { id,name,id };
		String namestr="";
		ArrayList<String[]> arrayList = sqlHelper.executeQuery("select distinct name,salary_number from info_user"
				+ " where orga_id = ? and depart_id =(select  depart_id from info_department where depart_name = ?  and orga_id = ?)" ,str);
		
		if (arrayList.size() > 0) {
			 for (int i = 0; i < arrayList.size(); i++) {
				 namestr=namestr.concat(arrayList.get(i)[0]+"-"+(arrayList.get(i)[1])+",");
			 }
		}
		//返回去掉最后逗号的字符串
		namestr = namestr.substring(0,namestr.length()-1);
		System.out.println(id);
		System.out.println(namestr);
		return namestr;
	}
	

}
