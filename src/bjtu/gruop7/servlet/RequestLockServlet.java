package bjtu.gruop7.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bjtu.gruop7.dao.LockDao;
import bjtu.gruop7.dao.MoneyDao;
import net.sf.json.JSONObject;

public class RequestLockServlet extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("UTF-8");
		
		LockDao lockdao = new LockDao();
		//前台获取传入的机构id值
		String lock = request.getParameter("lock") ;
		
		JSONObject js = new JSONObject();
		
		Boolean result = lockdao.requestLock(lock);
		if ("1".equals(lock)) {
			if(result){
				js.put("code","0");
				js.put("message", "数据库已加锁,帐户清零后自动解锁！");

			}else{
				js.put("code","1");
				js.put("message", "加锁失败！");
			}
		}else if ("0".equals(lock)){
			if(result){
				js.put("code","0");
				js.put("message", "数据库解锁成功！");

			}else{
				js.put("code","1");
				js.put("message", "数据库解锁失败！");
			}
		}
		
		response.getWriter().print(js.toString());
	}

}
