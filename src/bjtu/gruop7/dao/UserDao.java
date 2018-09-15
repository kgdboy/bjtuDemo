package bjtu.gruop7.dao;

import java.util.ArrayList;

import bjtu.gruop7.bean.UserBean;

public class UserDao {

	public UserDao() {
		// TODO 自动生成的构造函数存根
	}

	/**
	 * 返回部门名
	 * 
	 * @param username
	 * @param password
	 * @return
	 */
	public ArrayList<Object> signIn(String username, String password) {
		// TODO 自动生成的方法存根
		ArrayList<Object> arr = new ArrayList<>();
		UserBean userBean = new UserBean();
		bjtu.gruop7.util.SqlHelper sqlHelper = new bjtu.gruop7.util.SqlHelper();

		String[] str = { username, password };
		ArrayList<String[]> arrayList = sqlHelper.executeQuery(
				"select info_user.id,info_user.login_name,info_user.login_pass,info_user.orga_id,info_user.depart_id,info_organization.orga_name,"
						+ "info_department.depart_name,info_user.name,info_user.nation,info_user.duty,info_user.salary_number,"
						+ "info_user.tel,info_user.identity_num,info_user.lev,info_user.virtual_account from "
						+ "info_user join info_department on info_user.depart_id=info_department.depart_id join"
						+ " info_organization on info_organization.orga_id=info_department.orga_id where binary login_name = ? "
						+ "and binary login_pass = ?",
				str);

		if (arrayList.size() > 0) {
			int n = 0;
			userBean.setId(Integer.parseInt(arrayList.get(0)[n++]));
			userBean.setLogin_name(arrayList.get(0)[n++]);
			userBean.setLogin_pass(arrayList.get(0)[n++]);
			userBean.setOrga_id(arrayList.get(0)[n++]);
			userBean.setDepart_id(arrayList.get(0)[n++]);
			userBean.setOrga_name(arrayList.get(0)[n++]);
			userBean.setDepart_name(arrayList.get(0)[n++]);
			userBean.setName(arrayList.get(0)[n++]);
			userBean.setNation(arrayList.get(0)[n++]);
			userBean.setDuty(arrayList.get(0)[n++]);
			userBean.setSalary_number(arrayList.get(0)[n++]);
			userBean.setTel(arrayList.get(0)[n++]);
			userBean.setIdentity_num(arrayList.get(0)[n++]);
			userBean.setLev(arrayList.get(0)[n++]);
			userBean.setVirtual_account(Integer.parseInt(arrayList.get(0)[n++]));
			arr.add(0);
			arr.add("登陆成功！");

		} else {
			arr.add(1);
			arr.add("用户名或密码错误！");
		}
		arr.add(userBean);
		return arr;

	}

}
