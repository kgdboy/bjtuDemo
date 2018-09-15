package bjtu.gruop7.dao;

import java.util.ArrayList;

import bjtu.gruop7.util.SqlHelper;

public class RequestReservationDetialDao {
	private SqlHelper sqlHelper;
	private int count=0;
	private String dept_info="";
	private String coperson_infount="";
	public RequestReservationDetialDao( ) {
		sqlHelper=new SqlHelper();
	}
	
	public ArrayList<Object> requestReservationDetial(String orga_id, String reservation_category, String yearString,
			String monthString, String dayString) {
		// TODO 自动生成的方法存根
		ArrayList<Object> arrayList = new ArrayList<>();
		String[] str = { orga_id, reservation_category, yearString, monthString, dayString };

		ArrayList<String[]> arrSelect=sqlHelper.executeQuery("SELECT info_department.depart_name,count(info_user.`name`), group_concat(info_user.`name`) FROM data_order_food join info_department on info_department.depart_id=data_order_food.depart_id join info_user on info_user.salary_number=data_order_food.salary_number WHERE data_order_food.orga_id=? AND data_order_food.order_category=? AND data_order_food.order_year =? AND data_order_food.order_month =? AND data_order_food.order_day =? and data_order_food.is_del ='否' group by data_order_food.depart_id",
				str);
//		ArrayList<String[]> arrSelect=sqlHelper.executeQuery("SELECT info_department.depart_name,info_user.`name` FROM data_order_food join info_department on info_department.depart_id=data_order_food.depart_id join info_user on info_user.salary_number=data_order_food.salary_number WHERE data_order_food.orga_id=? AND data_order_food.order_category=? AND data_order_food.order_year =? AND data_order_food.order_money =? AND data_order_food.order_day =?",
//				str);
		if (arrSelect.size() > 0) {
			for (int i = 0; i < arrSelect.size(); i++) {
				
			coperson_infount+="<ii style='color:black';>"+arrSelect.get(i)[0]+
			":</ii>"+arrSelect.get(i)[2]+"<hr/>";
			dept_info+=	arrSelect.get(i)[0]+arrSelect.get(i)[1]+"人。";
			count+=Integer.parseInt(arrSelect.get(i)[1]);
			}


			arrayList.add(0);
			arrayList.add("查询成功！");
		} else {
			
			arrayList.add(0);
			arrayList.add("无人订餐！");

		}
		arrayList.add(count);
		arrayList.add(dept_info);
		arrayList.add(coperson_infount);
		return arrayList;
		
	}

}
