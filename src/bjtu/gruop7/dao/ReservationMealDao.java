package bjtu.gruop7.dao;

import java.util.ArrayList;
import java.util.Calendar;

import bjtu.gruop7.util.SqlHelper;

public class ReservationMealDao {
	private SqlHelper sqlHelper;
	private ArrayList<String[]> userArrayList;
	private String salary_number = "";
	private String orga_id = "";
	private String depart_id = "";
	private int virtual_account = 0;// 虚拟账户
	protected int newVirtualAccount = 0;

	public ReservationMealDao(String salary_number) {
		this.salary_number = salary_number;
		sqlHelper = new bjtu.gruop7.util.SqlHelper();
		userArrayList = sqlHelper.executeQuery(
				"select orga_id,depart_id,virtual_account from info_user where binary salary_number = ?",
				new String[] { salary_number });
		if (userArrayList.size() > 0) {
			orga_id = userArrayList.get(0)[0];
			depart_id = userArrayList.get(0)[1];
			virtual_account = Integer.parseInt((String) userArrayList.get(0)[2]);
		} else {
			System.out.println("传的工资号没找到！");
		}
	}

	/**
	 * 订餐
	 * 
	 * @param deduct_money价格
	 * @param reservation_category订餐类别
	 * @param calendar时间
	 * @return
	 */
	public ArrayList<Object> orderMeal(int deduct_money, String reservation_category, Calendar calendar) {
		// TODO 自动生成的方法存根
		ArrayList<Object> arrayList = new ArrayList<>();
		String year = String.valueOf(calendar.get(Calendar.YEAR));
		String month = String.valueOf(calendar.get(Calendar.MARCH));
		String day = String.valueOf(calendar.get(Calendar.DAY_OF_MONTH));
		String[] str = { orga_id, depart_id, salary_number, year, month, day, reservation_category,
				String.valueOf(deduct_money) };

		int tag = 0;
		int tag2 = 0;
		ArrayList<String[]> arrSelect=sqlHelper.executeQuery("select * from data_order_food where orga_id=? and depart_id=? and salary_number=? and order_year=? and order_month=? and order_day=? and order_category=? and order_money=? and is_del= '否'",
				str);
		if(arrSelect.size()>0){
			newVirtualAccount = virtual_account;
			arrayList.add(1);
			arrayList.add("订餐失败，您已订餐！");
			arrayList.add(newVirtualAccount);
			return arrayList;
		}
		tag = sqlHelper.executeUpdate(
				"INSERT ignore INTO data_order_food(orga_id,depart_id,salary_number,order_year,order_month,order_day,order_category,order_money) VALUES (?,?,?,?,?,?,?,?)",
				str);
		if (tag > 0) {
			// 订餐成功，从账户余额扣除

			String[] str2 = { String.valueOf(deduct_money), salary_number };
			tag2 = sqlHelper.executeUpdate(
					"UPDATE info_user SET virtual_account=virtual_account-? WHERE binary salary_number = ?", str2);

		} else {
			newVirtualAccount = virtual_account;
			arrayList.add(1);
			arrayList.add("订餐失败，这条sql语句没有插入进去");
			arrayList.add(newVirtualAccount);
			return arrayList;
		}
		if (tag2 > 0) {
			newVirtualAccount = virtual_account - deduct_money;
			arrayList.add(0);
			arrayList.add("订餐成功，从账户余额扣除");
		} else {
			newVirtualAccount = virtual_account;
			arrayList.add(1);
			arrayList.add("订餐成功，但从未账户余额扣除");
		}
		arrayList.add(newVirtualAccount);
		return arrayList;
	}

	/**
	 * 退餐
	 * 
	 * @param deduct_money
	 * @param reservation_category
	 * @param calendar
	 * @return
	 */
	public ArrayList<Object> cancelOrderMeal(int deduct_money, String reservation_category, Calendar calendar) {
		// TODO 自动生成的方法存根
		ArrayList<Object> arrayList = new ArrayList<>();
		String year = String.valueOf(calendar.get(Calendar.YEAR));
		String month = String.valueOf(calendar.get(Calendar.MARCH));
		String day = String.valueOf(calendar.get(Calendar.DAY_OF_MONTH));
		String[] str = { orga_id, depart_id, salary_number, year, month, day, reservation_category,
				String.valueOf(deduct_money),"否"};

		int tag = 0;
		int tag2 = 0;
		ArrayList<String[]> arrSelect=sqlHelper.executeQuery("select * from data_order_food where orga_id=? and depart_id=? and salary_number=? and order_year=? and order_month=? and order_day=? and order_category=? and order_money=? and is_del= ?",
				str);
		if(arrSelect.size()<=0){
			newVirtualAccount = virtual_account;
			arrayList.add(1);
			arrayList.add("抱歉，您还没有订餐！");
			arrayList.add(newVirtualAccount);
			return arrayList;
		}
		tag = sqlHelper.executeUpdate(
				"UPDATE data_order_food SET is_del ='是' where orga_id = ? and depart_id = ? and salary_number = ? and order_year = ? and order_month = ? and order_day = ? and order_category = ? and order_money = ? and is_del= ?",
				str);
//		tag = sqlHelper.executeUpdate(
//				"INSERT ignore INTO data_order_food(orga_id,depart_id,salary_number,order_year,order_month,order_day,order_category,order_money) VALUES (?,?,?,?,?,?,?,?)",
//				str);
		if (tag > 0) {
			// 退餐，

			String[] str2 = { String.valueOf(deduct_money), salary_number };
			tag2 = sqlHelper.executeUpdate(
					"UPDATE info_user SET virtual_account=virtual_account+? WHERE binary salary_number = ?", str2);

		} else {
			newVirtualAccount = virtual_account;
			arrayList.add(1);
			arrayList.add("退餐失败，这条sql语句没有插入进去");
			arrayList.add(newVirtualAccount);
			return arrayList;
		}
		if (tag2 > 0) {
			newVirtualAccount = virtual_account + deduct_money;
			arrayList.add(0);
			arrayList.add("退餐成功，已将扣款返回至账户");
		} else {
			newVirtualAccount = virtual_account;
			arrayList.add(1);
			arrayList.add("退餐成功，但未将扣款返回至账户");
		}
		arrayList.add(newVirtualAccount);
		return arrayList;
	}

}
