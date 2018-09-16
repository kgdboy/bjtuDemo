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
		String[] str = { salary_number };
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

	public static Boolean requestTf(String salary_number, String je) {
		bjtu.gruop7.util.SqlHelper sqlHelper = new bjtu.gruop7.util.SqlHelper();
		String[] str = { je,salary_number};
		int a = sqlHelper
				.executeUpdate("update info_user set virtual_account=virtual_account-? where salary_number=?",str);
		if(a>0){
			return true;
		}else {
			return false;
		}

	}
}
