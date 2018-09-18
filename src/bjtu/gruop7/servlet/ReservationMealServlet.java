package bjtu.gruop7.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bjtu.gruop7.dao.LockDao;
import bjtu.gruop7.service.ReservationMealService;
import net.sf.json.JSONObject;

public class ReservationMealServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6100737938888934052L;

	/**
	 * Constructor of the object.
	 */
	public ReservationMealServlet() {
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
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to
	 * post.
	 * 
	 * @param request
	 *            the request send by the client to the server
	 * @param response
	 *            the response send by the server to the client
	 * @throws ServletException
	 *             if an error occurred
	 * @throws IOException
	 *             if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// 状态字
		int code = 1;
		String message = "";
		int deduct_money =0;
		int virtual_account =0;
		// 转换编码
		response.setContentType("text/html;charset=utf-8");
		// post中文乱码
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8"); 
		
		//判断数据库是否加锁
		LockDao lockdao = new LockDao();
		Boolean lockstatus = lockdao.queryLockstatus("1");
		if (!lockstatus) {
			// 订餐类别reservation_category
			// 订餐人员工资号salary_number
			// 请求状态request_status
			String reservation_category = request.getParameter("reservation_category");
			String salary_number = request.getParameter("salary_number");
			String request_status = request.getParameter("request_status");

			if (null == reservation_category || "".equals(reservation_category)) {
				code = 1;
				message = "未能获取到reservation_category！";
			} else if (null == salary_number || "".equals(salary_number)) {
				code = 1;
				message = "未能获取到salary_number！";
			} else if (null == request_status || "".equals(request_status)) {
				code = 1;
				message = "未能获取到request_status！";
			} else {
				// 创建dao对象
				ReservationMealService service = new ReservationMealService();
				ArrayList<Object> arr = service.requestMoney(reservation_category, salary_number, request_status);
				// 设置标记
				code = (int) arr.get(0);
				message = (String) arr.get(1);
				deduct_money=(int)arr.get(2);
				virtual_account=(int) arr.get(3);
				// 输出状态字到前台
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("code", code);
				jsonObject.put("message", message);
				// 本次订餐所扣金额
				jsonObject.put("deductMoney", deduct_money);
				// 返回的用户订餐后的余额
				jsonObject.put("virtual_account", virtual_account);

				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				out.println(jsonObject);
				out.flush();
				out.close();
			}
		}else{
			// 输出状态字到前台
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("code", "1");
			jsonObject.put("message", "管理员正在结算,请稍候订餐");
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.println(jsonObject);
			out.flush();
			out.close();
		}
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException
	 *             if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
