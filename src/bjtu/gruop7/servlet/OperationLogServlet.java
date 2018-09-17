package bjtu.gruop7.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bjtu.gruop7.dao.OperationLogDao;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class OperationLogServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4271318176195082978L;

	/**
		 * Constructor of the object.
		 */
	public OperationLogServlet() {
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
		int code = 1;
		String message = "";
		int count=0;
		JSONArray jsonArray=new JSONArray();
		// 转换编码
		response.setContentType("text/html;charset=utf-8");
		// post中文乱码
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

//		OperationLogServlet
//		6个
//		Page(必传）	用户选择的页码
//		limit(必传）	用户选择一页显示的条数
//		orga_id(必传）	用户机构号
//		dc_date(必传）	日期区间
//		name(选传）	用户名称
//		cx_lb(选传）	查询类别
		String Page = request.getParameter("page");
		String limit = request.getParameter("limit");
		String orga_id = request.getParameter("orga_id");
		String dc_date = request.getParameter("dc_date");
		String name = request.getParameter("name");
		String cx_lb = request.getParameter("cx_lb");
		
		if (null == Page || "".equals(Page)) {
			code = 1;
			message = "Page没有传过来！";
		} else if (null == limit || "".equals(limit)) {
			code = 1;
			message = "limit没有传过来！";
		} else if (null == orga_id || "".equals(orga_id)) {
			code = 1;
			message = "orga_id没有传过来！";
		} else if (null == dc_date || "".equals(dc_date)) {
			code = 1;
			message = "dc_date没有传过来！";
		} else if (null == name) {
			code = 1;
			message = "name没有传过来！";
		} else if (null == cx_lb) {
			code = 1;
			message = "cx_lb没有传过来！";
		} else {

			OperationLogDao operationLogDao = new OperationLogDao();
			ArrayList<Object> arr = operationLogDao.operationLog(Page,limit,orga_id,dc_date,name,cx_lb);
			// 设置标记
			code = (int) arr.get(0);
			message = (String) arr.get(1);
			count=(int)arr.get(2);
			jsonArray=(JSONArray) arr.get(3);
		}
		
		// 输出状态字到前台
				JSONObject jsonObject = new JSONObject();
				
				jsonObject.put("code", code);
				jsonObject.put("message", message);
				jsonObject.put("count", count);
				jsonObject.put("data", jsonArray);

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
