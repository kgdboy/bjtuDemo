package bjtu.gruop7.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bjtu.gruop7.dao.CountedDao;
import bjtu.gruop7.dao.DepartDao;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
public class TestReturnDepartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public TestReturnDepartServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
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
			String bmstr = DepartDao.returnDepartName(id);
			response.getWriter().print(bmstr);
		}
	}

}
