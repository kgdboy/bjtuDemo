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
import bjtu.gruop7.dao.UserDao;
import net.sf.json.JSONObject;

public class SignInServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4965737033663395405L;

	/**
		 * Constructor of the object.
		 */
	public SignInServlet() {
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
		int signUpCode=1;
		String message="";
		UserBean userBean=new UserBean();
		// 转换编码
		response.setContentType("text/html;charset=utf-8");
		//post中文乱码
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
//		登陆时我会POST到后台四个参数： name , pass , code ,yzm_rzt
//		name  登陆名
//		pass  密码
//		code 用户所填验证码
//		yzm_rzt   系统自动计算的验证码
		 
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String code = request.getParameter("code");
		String yzm_rzt = request.getParameter("yzm_rzt");
		if(null==username||"".equals(username)){
			signUpCode=1;
			message="请输入用户名！";
		}else if(null==password||"".equals(password)){	
			signUpCode=1;
			message="请输入密码！";
		}else if(null==code||"".equals(code)){
			signUpCode=1;
			message="请输入验证码！";
		}else if(null==yzm_rzt||"".equals(yzm_rzt)){
			signUpCode=1;
			message="抱歉，后台计算的验证码没传过来，无法进行验证！";
		}else if(!yzm_rzt.equals(code)){
			signUpCode=1;
			message="验证码输入有误！";
		}else{
			//创建dao对象，对用户名密码进行验证
			UserDao userDao=new UserDao();
			ArrayList<Object> arr = userDao.signIn(username, password);
			//设置标记
			signUpCode=(int) arr.get(0);
			message=(String) arr.get(1);
			userBean=(UserBean)arr.get(2);
		}
		// 验证登陆
		
				// 存session
				if(signUpCode==0){
				HttpSession session = request.getSession();
				session.setAttribute("UserBean", userBean);
				 session.setAttribute("age","1233"); 
				
				}
		
		// 输出状态字到前台
		JSONObject jsonObject=new JSONObject();
		jsonObject.put("code",signUpCode);
		jsonObject.put("message", message);
		jsonObject.put("bm", userBean.getDepart_name());
		jsonObject.put("name", userBean.getName());
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.println(jsonObject);
		out.flush();
		out.close();

		
//		需要后台将用户信息bean装入SESSION中，并给我返回如下JSON格式：
//		{"code":0,"message":"无","bm":"管控中心","name":"吴戈"};
//		code:状态码，能登陆0，不能登陆1.
//		message: 登录成功为空，登录不成功，写好原因。
//		bm: 用户所在部门
//		name: 用户真实姓名
		
		
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
