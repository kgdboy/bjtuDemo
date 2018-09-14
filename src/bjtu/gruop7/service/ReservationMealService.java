package bjtu.gruop7.service;

import java.util.ArrayList;
import java.util.Calendar;

import bjtu.gruop7.dao.ReservationMealDao;

public class ReservationMealService {

	// 订餐类别reservation_category
	// 订餐人员工资号salary_number
	// 请求状态request_status
	public ArrayList<Object> requestMoney(String reservation_category, String salary_number, String request_status) {
		ArrayList<Object> arr=new ArrayList<>();
		ReservationMealDao dao=new ReservationMealDao(salary_number);
		int deduct_money=0;
		int virtual_account=0;
		Calendar calendar=Calendar.getInstance();


		int tag=0;
		//订餐逻辑
		if("早餐".equals(reservation_category)){
			tag=1;
			//获取价格
			deduct_money=2;
		}else if("午餐".equals(reservation_category)){
			tag=2;
			//获取价格
			deduct_money=2;
		}else if("晚餐".equals(reservation_category)){
			tag=3;
			//获取价格
			deduct_money=6;
		}
		//时间
		switch (tag) {
		case 1:
			if(Calendar.getInstance().get(Calendar.HOUR_OF_DAY)>=0){
				calendar.add(Calendar.DAY_OF_MONTH, 1);
		}
			break;
		case 2:
			if(Calendar.getInstance().get(Calendar.HOUR_OF_DAY)>=9){
				calendar.add(Calendar.DAY_OF_MONTH, 1);
		}
			break;
		case 3:
			if(Calendar.getInstance().get(Calendar.HOUR_OF_DAY)>=14){
				calendar.add(Calendar.DAY_OF_MONTH, 1);
		}
			break;

		default:
			arr.add(1);
			arr.add("未能获取到您的需求，系统不知道您是需要订哪一餐？");
			arr.add(deduct_money);//deductMoney本次订餐所扣金额
			arr.add(virtual_account);//virtual_account返回的用户订餐后的余额
			return arr;
		}
		
		
		if("订餐".equals(request_status)){
			ArrayList<Object> arrayList=dao.orderMeal(deduct_money,reservation_category,calendar); 
			arr.add(arrayList.get(0));
			arr.add(arrayList.get(1));
			virtual_account=(int)arrayList.get(2);
//			arr.add(0);
//			arr.add("您已成功订餐！本次订餐扣除："+deductMoney+"元，您的账户所剩余额为："+virtual_account+"元。");
			
		}else if("退餐".equals(request_status)) {
			ArrayList<Object> arrayList=dao.cancelOrderMeal(deduct_money,reservation_category,calendar);
			
			arr.add(arrayList.get(0));
			arr.add(arrayList.get(1));
			virtual_account=(int)arrayList.get(2);
//			arr.add(0);
//			arr.add("取消订餐成功！返还订餐金额："+deductMoney+"元，您的账户所剩余额为："+virtual_account+"元。");
			
		}else {
			arr.add(1);
			arr.add("未能获取到您的需求，请问您是需要订餐还是退餐？");
		}
		arr.add(deduct_money);//deductMoney本次订餐所扣金额
		arr.add(virtual_account);//virtual_account返回的用户订餐后的余额
		
		return arr;
		
	}

}
