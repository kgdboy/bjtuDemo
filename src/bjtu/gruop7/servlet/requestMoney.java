package bjtu.gruop7.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bjtu.gruop7.bean.UserBean;
import bjtu.gruop7.dao.MoneyDao;
import bjtu.gruop7.dao.UserDao;
import net.sf.json.JSONObject;

public class requestMoney extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 状态字
		int code=0;
		String message="";
		//余额初始化
		Integer money = null;
		// 转换编码
		response.setContentType("text/html;charset=utf-8");
		//post中文乱码
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
//		登陆时我会POST到后台1个参数：salary_number
//		salary_number  工资号

		String salary_number = request.getParameter("salary_number");
	
		if(null==salary_number||"".equals(salary_number)){
			code=1;
			message="未获取到工资号";
		}else{
			//创建dao对象，对用户名密码进行验证
//			MoneyDao moneyDao = new MoneyDao();
			
//			ArrayList<Object> arr = moneyDao.getMoney(salary_number);
			//设置标记
//			code=(int) arr.get(0);
//			message=(String) arr.get(1);
//			money=(int)arr.get(2);
		}

		// 输出状态字到前台
		JSONObject jsonObject=new JSONObject();
		jsonObject.put("code",code);
		jsonObject.put("message", message);
		
		jsonObject.put("virtual_account",1000);
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println(jsonObject);
		out.flush();
		out.close();
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doGet(req, resp);
	}

}
