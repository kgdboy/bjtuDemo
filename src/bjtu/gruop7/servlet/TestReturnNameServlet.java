package bjtu.gruop7.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.org.apache.xpath.internal.operations.And;

import bjtu.gruop7.dao.DepartDao;
import bjtu.gruop7.dao.NameDao;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class TestReturnNameServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("UTF-8");

		//前台获取传入的机构id值
		String id = request.getParameter("orga_id") ;
		String name = request.getParameter("depart_name");
		
		JSONArray jArray = new JSONArray();
		JSONObject js = new JSONObject();

		if("".equals(id) && "".equals(name)){
			js.put("code","1");
			js.put("message", "您所传入的值为空！");
			//将错误信息传向前台
			response.getWriter().print(jArray.toString());
		}else{	
			String namestr = NameDao.returnName(id,name);
			response.getWriter().print(namestr);
			
		}
	}

}


