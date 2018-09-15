package bjtu.gruop7.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bjtu.gruop7.dao.RequestReservationDetialDao;
import net.sf.json.JSONObject;

public class RequestReservationDetialServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4443570555594592718L;

	/**
		 * Constructor of the object.
		 */
	public RequestReservationDetialServlet() {
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
	// 转换编码
	response.setContentType("text/html;charset=utf-8");
	// post中文乱码
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	
	//机构
	String orga_id = request.getParameter("orga_id");
	//订餐时间
	String reservation_date = request.getParameter("reservation_date");
	//订餐类别
	String reservation_category = request.getParameter("reservation_category");
	//返回count
	int count=0;
	//返回dept_info
	String dept_info="";
	//返回person_info
	String person_info="";
	
	if (null == orga_id || "".equals(orga_id)) {
		code = 1;
		message = "没有获取到机构id：orga_id";
	} else if (null == reservation_date || "".equals(reservation_date)) {
		code = 1;
		message = "没有获取到订餐时间：reservation_date";
	} else if (null == reservation_category || "".equals(reservation_category)) {
		code = 1;
		message = "没有获取到订餐类别：reservation_category";
	} else {
		String yearString="";
		String monthString="";
		String dayString = "";
		try {
			String s[]=reservation_date.split("-"); 
			yearString=s[0];
			monthString=s[1];
			dayString=s[2];
		} catch (Exception e) {
			code = 1;
			message = "日期格式不正确！";
		}
		RequestReservationDetialDao requestReservationDetialDao = new RequestReservationDetialDao();
		ArrayList<Object> arr = requestReservationDetialDao.requestReservationDetial(orga_id, reservation_category,yearString,monthString,dayString);
		// 设置标记
		code = (int) arr.get(0);
		message = (String) arr.get(1);
		count= (int) arr.get(2);
		dept_info = (String) arr.get(3);
		person_info = (String) arr.get(4);
	}


	// 输出状态字到前台
	JSONObject jsonObject = new JSONObject();
	jsonObject.put("code", code);
	jsonObject.put("message", message);
	jsonObject.put("count", count);
	jsonObject.put("dept_info", dept_info);
	jsonObject.put("person_info", person_info);

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
