package bjtu.gruop7.servlet;



import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bjtu.gruop7.bean.UserBean;
import bjtu.gruop7.dao.CountedDao;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


/**
 * Servlet implementation class countedServlet
 */

public class RequestReckoningServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RequestReckoningServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		response.setContentType("UTF-8");
		//获取前台传入的机构id
		String id = request.getParameter("orga_id") ;
		//定义json数组
		JSONArray jArray = new JSONArray();
		//定义json对象
		JSONObject js = new JSONObject();
		//判断前台传入值是否为空
		if("".equals(id)){
			js.put("code","1");
			js.put("message", "您所传入的值为空！");
		
			//将错误信息传向前台
			response.getWriter().print(jArray.toString());
		}else{
			
		try {

			//根据传入的机构id,查询相关信息
			List <UserBean> list = CountedDao.counted(Integer.valueOf(id));	
			//判断是否查询到相关数据，没有找到给前台返回错误信息
			if(null == list){
				js.put("code","1");
				js.put("message", "没有找到相应数据！");
				
				//将错误信息传向前台
			}else{
				//将找到值赋给json格式的数组jArray.并返回前台。
				js.put("code","0");
				js.put("message", "正常！");
				js.put("data", list);
				
//			for (int i = 0; i < list.size(); i++) {
//				js.put("depart_name", list.get(i).getDepart_name());
//				js.put("depart_name", list.get(i).getDepart_name());
//				js.put("orga_name", list.get(i).getOrga_name());
//				js.put("salary_number", list.get(i).getSalary_number());
//				js.put("login_name", list.get(i).getLogin_name());
//				js.put("virtual_account", list.get(i).getVirtual_account());
//			}
			}
			response.getWriter().print(js.toString());
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	};
	}


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request,response);
	}

}
