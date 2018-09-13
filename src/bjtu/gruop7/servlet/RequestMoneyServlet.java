package bjtu.gruop7.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bjtu.gruop7.dao.MoneyDao;
import net.sf.json.JSONObject;

public class RequestMoneyServlet extends HttpServlet {

	/**
		 * Constructor of the object.
		 */
	public RequestMoneyServlet() {
		super();
	}

	/**
		 * Destruction of the servlet. <br>
		 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
		 * The doGet method of the servlet. <br>
		 *
		 * This method is called when a form has its tag value method equals to get.
		 * 
		 * @param request the request send by the client to the server
		 * @param response the response send by the server to the client
		 * @throws ServletException if an error occurred
		 * @throws IOException if an error occurred
		 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		this.doPost(request, response);
	}

	/**
		 * The doPost method of the servlet. <br>
		 *
		 * This method is called when a form has its tag value method equals to post.
		 * 
		 * @param request the request send by the client to the server
		 * @param response the response send by the server to the client
		 * @throws ServletException if an error occurred
		 * @throws IOException if an error occurred
		 */
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
		
		String salary_number = request.getParameter("salary_number");
		if(null==salary_number||"".equals(salary_number)){
			code=1;
			message="未获取到工资号";
		}else{
			//创建dao对象，对用户名密码进行验证
			MoneyDao moneyDao = new MoneyDao();
			
			ArrayList<Object> arr = moneyDao.getMoney(salary_number);
			//设置标记
			code=(int) arr.get(0);
			message=(String) arr.get(1);
			money=Integer.parseInt((String) arr.get(2));
		}

		// 输出状态字到前台
		JSONObject jsonObject=new JSONObject();
		jsonObject.put("code",code);
		jsonObject.put("message", message);
		
		jsonObject.put("virtual_account",money);
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println(jsonObject);
		out.flush();
		out.close();
				
	}

	/**
		 * Initialization of the servlet. <br>
		 *
		 * @throws ServletException if an error occurs
		 */
	public void init() throws ServletException {
		// Put your code here
	}

}
