package bjtu.gruop7.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import bjtu.gruop7.bean.UserBean;
import net.sf.json.JSONObject;
public class TestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// 转换编码
		/*response.setContentType("text/html;charset=utf-8");
		//post中文乱码
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		ArrayList<UserBean> list = new ArrayList<UserBean>();
		UserBean userBean = new UserBean();
		userBean.setId(23);
		userBean.setName("1吴戈1");
		userBean.setDepart_name("管控中心");
		userBean.setLev("1");
		UserBean userBean2 = new UserBean();
		userBean2.setId(25);
		userBean2.setName("2李辛平1");
		userBean2.setDepart_name("检修车间");
		userBean2.setLev("2");
		list.add(0,userBean);
		list.add(1,userBean2);
		request.setAttribute("user", list);
		request.getRequestDispatcher("/page/food/test.jsp").forward(request, response);
		// 输出状态字到前台
				JSONObject jsonObject=new JSONObject();
				jsonObject.put("code",0);
				jsonObject.put("message", "无");
				jsonObject.put("data",list);
				
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				out.println(jsonObject);
				out.flush();
				out.close();*/
		

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String orga_id = req.getParameter("orga_id");

		resp.setContentType("text/html;charset=utf-8");
		//post中文乱码
		req.setCharacterEncoding("UTF-8");
		req.setCharacterEncoding("UTF-8");
		ArrayList<UserBean> list = new ArrayList<UserBean>();
		UserBean userBean = new UserBean();
		userBean.setSalary_number("0372683");
		userBean.setName("吴戈");
		userBean.setDepart_name("管控中心");
		userBean.setVirtual_account(40);
		UserBean userBean2 = new UserBean();
		userBean2.setSalary_number("0022225");
		userBean2.setName("李辛平");
		userBean2.setDepart_name("检修车间");
		userBean2.setLev("1,2");
		userBean2.setVirtual_account(-20);
		UserBean userBean3 = new UserBean();
		userBean3.setSalary_number("0033222");
		userBean3.setName("衣长清");
		userBean3.setDepart_name("办公室");
		userBean3.setLev("2,4");
		userBean3.setVirtual_account(-22);
		list.add(0,userBean);
		list.add(1,userBean2);
		list.add(2,userBean3);
		/*request.setAttribute("user", list);
		request.getRequestDispatcher("/page/food/test.jsp").forward(request, response);*/
		// 输出状态字到前台
		JSONObject jsonObject=new JSONObject();
		jsonObject.put("code",0);
		jsonObject.put("message", "正常");
		jsonObject.put("data",list);
		
		PrintWriter out = resp.getWriter();
		out.println(jsonObject);
		out.flush();
		out.close();
		
	}

}
