package bjtu.gruop7.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class TestLogServlet extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		//post中文乱码
		response.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		// 输出状态字到前台
		JSONObject jsonObject=new JSONObject();
		JSONObject jsonObject1=new JSONObject();
		jsonObject1.put("id",1000);
		jsonObject1.put("name","吴戈");
		jsonObject1.put("log_date","2018-09-28 12:3:11");
		jsonObject1.put("log_category","订餐");
		jsonObject1.put("log_content","吴戈在2018-09-28 12:3:11 进行了预订早餐操作,订餐前余额为10元，订餐后余额为8元，扣费成功。");
//		第2组数据
		JSONObject jsonObject2=new JSONObject();
		jsonObject2.put("xh",2000);
		jsonObject2.put("name","李辛平");
		jsonObject2.put("log_date","2018-02-38 09:13:31");
		jsonObject2.put("log_category","退餐");
		jsonObject2.put("log_content","李辛平在2018-02-38 09:13:31 进行了退订午餐操作,订餐前余额为90元，订餐后余额为92元，退费成功。");
		
		JSONArray jsonArray = new JSONArray();
		
		jsonArray.add(jsonObject1);
		jsonArray.add(jsonObject2);
		
		jsonObject.put("code",0);
		jsonObject.put("msg","");
		jsonObject.put("count",1);
		jsonObject.put("data",jsonArray);
		
		
		PrintWriter out = response.getWriter();
		out.println(jsonObject);
		out.flush();
		out.close();
	}

}
