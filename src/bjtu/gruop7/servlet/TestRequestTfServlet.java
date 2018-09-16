package bjtu.gruop7.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bjtu.gruop7.dao.CountedDao;
import bjtu.gruop7.dao.MoneyDao;
import net.sf.json.JSONObject;

public class TestRequestTfServlet extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("UTF-8");
		MoneyDao moneyDao = new MoneyDao();
		//前台获取传入的机构id值
		String salary_number = request.getParameter("salary_number") ;
		String je = request.getParameter("je") ;
		JSONObject js = new JSONObject();
		
		Boolean result = MoneyDao.requestTf(salary_number,je);
		
		if(result){
			js.put("code","0");
			js.put("message", "正常！");

		}else{
			js.put("code","1");
			js.put("message", "清零没有成功！");

		}
		response.getWriter().print(js.toString());
	}
}
