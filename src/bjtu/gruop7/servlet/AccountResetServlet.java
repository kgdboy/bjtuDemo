package bjtu.gruop7.servlet;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bjtu.gruop7.dao.CountedDao;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


public class AccountResetServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
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
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("UTF-8");

		//前台获取传入的机构id值
		String id = request.getParameter("orga_id") ;
		JSONArray jArray = new JSONArray();
		JSONObject js = new JSONObject();

		if("".equals(id)){
			js.put("code","1");
			js.put("message", "您所传入的值为空！");
		
			//将错误信息传向前台
			response.getWriter().print(jArray.toString());
		}else{		
		
			Boolean result = CountedDao.accountReset(id);
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
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
			doGet(request,response);
	}

}
