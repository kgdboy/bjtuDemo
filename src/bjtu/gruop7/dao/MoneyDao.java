package bjtu.gruop7.dao;

import java.util.ArrayList;

public class MoneyDao {
	public MoneyDao() {

	}

	/**
	 * 根据工资号返回余额
	 * 
	 * @param salary_number
	 * @return virtual_account
	 */
	public ArrayList<Object> getMoney(String salary_number) {

		ArrayList<Object> arr = new ArrayList<>();
		bjtu.gruop7.util.SqlHelper sqlHelper = new bjtu.gruop7.util.SqlHelper();
		// System.out.println("md:"+sqlHelper);
		String[] str = { salary_number };
		// System.out.println("%%%%%%%%%%%%%");
		// System.out.println(salary_number);
		// ArrayList<String[]> arrayList = sqlHelper.executeQuery("select * from
		// info_user where salary_number=?",
		// str);
		ArrayList<String[]> arrayList = sqlHelper
				.executeQuery("select virtual_account from " + "info_user where salary_number =?", str);
		if (arrayList.size() > 0) {
			arr.add(0);
			arr.add("获取成功！");
			// System.out.println("cg!");
		} else {
			arr.add(1);
			arr.add("获取失败！");
			// System.out.println("error");
		}
		arr.add(arrayList.get(0)[0]);
		return arr;

	}
}
