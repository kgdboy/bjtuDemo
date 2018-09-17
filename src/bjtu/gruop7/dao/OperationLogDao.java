package bjtu.gruop7.dao;
import java.util.ArrayList;
import bjtu.gruop7.util.SqlHelper;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class OperationLogDao {
	private SqlHelper sqlHelper;
	private int page=0;
	private int limit=0;
	private int count=0;
	
	public OperationLogDao() {
		sqlHelper=new SqlHelper();
	}
	public ArrayList<Object> operationLog(String page, String limit, String orga_id, String dc_date, String name,
			String cx_lb) {
		// TODO 自动生成的方法存根
		this.page=Integer.parseInt(page);
		this.limit=Integer.parseInt(limit);
		ArrayList<Object> arr = new ArrayList<>();
		JSONArray data=new JSONArray();
		//dc_date拆时间，判断范围
		String[] dateRoom = dc_date.split("~");
			String str[]={dateRoom[0],dateRoom[1]+" 23:59:59",name,cx_lb,orga_id};
		String sql="select Id,`name`,log_date,log_category,log_content from log where log_date BETWEEN ? AND ?  and if("+name.length()+", name like concat('%',?,'%'),'1=1') and if("+cx_lb.length()+", log_category like concat('%',?,'%'),'1=1') and orga_id=? order by id desc limit "+(this.page-1)*this.limit+","+this.limit;
		ArrayList<String[]> arrayList = sqlHelper.executeQuery(sql,str);
		
		if (arrayList.size() > 0) {
			for (int i = 0; i < arrayList.size(); i++) {
				JSONObject jsonObject=new JSONObject();
				jsonObject.put("id", arrayList.get(i)[0]);
				jsonObject.put("name", arrayList.get(i)[1]);
				jsonObject.put("log_date", arrayList.get(i)[2].substring(0,arrayList.get(i)[2].indexOf(".")));
				jsonObject.put("log_category", arrayList.get(i)[3]);
				jsonObject.put("log_content",arrayList.get(i)[1]+"于"+arrayList.get(i)[2]+"进行了"+arrayList.get(i)[3]+"操作，"+ arrayList.get(i)[4]);
				count++;
				data.add(jsonObject);
			}
			arr.add(0);
			arr.add("查询成功！");
		} else {
			arr.add(0);
			arr.add("查询失败！");
		}
		arr.add(count);
		arr.add(data);
		return arr;
	}

}
