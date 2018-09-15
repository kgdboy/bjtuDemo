package bjtu.gruop7.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import bjtu.gruop7.bean.UserBean;
import bjtu.gruop7.util.JdbcUtils;
import bjtu.gruop7.util.SqlHelper;

import java.lang.String;

/**
 * 结算
 * @author Administrator
 *
 */

     //连接数据库
public class  CountedDao {
	public static Connection conn() throws SQLException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/bjtudemo";
			String user = "root";
			String password = "Wrx1217***";
			Connection conn =DriverManager.getConnection(url, user, password);
			return conn;
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
/**
 * 提取当前机构各用户的虚拟账号余额
 * @param id 前台需要的机构id值
 * @return 返回 查询到的结果集
 */
	public static List<UserBean> counted(int id)  {
		String sql = "select info_user.salary_number,info_user.name, info_organization.orga_name,"+
				"info_department.depart_name,info_user.virtual_account from info_user"+
				" join info_organization on info_user.orga_id = info_organization.orga_id "+
				" join info_department on info_department.depart_id = info_user.depart_id "+
				" where info_user.orga_id="+id+" and info_user.virtual_account < 0;";
	
	try {
		JdbcUtils jdbcUtils = JdbcUtils.getInstance();
		Connection conn = jdbcUtils.getConnection();

		ArrayList<UserBean> list = new ArrayList<UserBean>();
		PreparedStatement pre = conn.prepareStatement(sql);
		ResultSet re = pre.executeQuery();

		while (re.next()) {
			UserBean cm = new UserBean();
			cm.setDepart_name(re.getNString("info_department.depart_name"));
			cm.setOrga_name(re.getString("info_organization.orga_name"));
			cm.setSalary_number(re.getString("info_user.salary_number"));
			cm.setName(re.getString("info_user.name"));
			cm.setVirtual_account(re.getInt("info_user.virtual_account"));
			list.add(cm);
			}		
			
			if(list.size()==0){
				return null;
			}else{
				return list;
			}
			
		} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		}
	return null;
}
	/**
	 * 虚拟账户余额清零
	 * @param id
	 * @return
	 */
	public static boolean accountReset(String id){
		
		
		String sql = "update info_user set virtual_account = 0 where info_user.orga_id=?";
		SqlHelper sqlHelper = new SqlHelper();
		String[] str = {id}; 
		int a=sqlHelper.executeUpdate(sql,str);
//			JdbcUtils jdbcUtils = new JdbcUtils();
//			Connection conn = jdbcUtils.getConnection();
//			PreparedStatement pre = conn.prepareStatement(sql);
//			pre.executeUpdate();
		if(a>0)return true;
		else {
			return false;
		}
	}
	
//	public static List<CookBookBean> cookBook(){
//		
//		//month(Date())返加月份值 
//		//find_in_set(str,string)返回str在string中的位置
//		
//		
//		try {
//			String sql = "select * from info_cookselect;";
//			System.out.println(sql);
//			PreparedStatement pre = conn().prepareStatement(sql);
//			ResultSet re = pre.executeQuery();
//			List<CookBookBean> cooklist = new ArrayList<CookBookBean>();
//			while (re.next()) {
//				long time = System.currentTimeMillis();
//				Date date = new Date(time);
//				Calendar c = Calendar.getInstance();
//				c.setTime(date);
//				String monthNow = String.valueOf(c.get(Calendar.MONTH)+1);
//				System.out.println(monthNow);
//				
//				String monthDb = re.getString("month");
//				System.out.println(monthDb);
//				
//				if (IndexOf(monthNow,monthDb)) {
//					CookBookBean cb = new CookBookBean();
//					cb.setId(re.getInt("id"));
//					cb.setMonth(re.getString("month"));
//					cb.setClitocybine(re.getString("clitocybine"));
//					cb.setCooking(re.getString("cooking"));
//					cb.setDish_name(re.getString("dish_name"));
//					cooklist.add(cb);				
//				};
//			}
//			return cooklist;
//		
//		
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		return null;
//	}
	/*
	 * 判断数据库中当前记录的月份是否包含当前月
	 */
	private static boolean IndexOf(String Now, String Db) {
		int i = 0;
		int l = Db.length();
		while (i < l ) {
			 String db1 = String.valueOf(Db);
			if (Now.equals(db1)){
				return true;
			}
			i++;		
		}
				return false;
	}

	public static void main(String[] args) {
		
		try {
			System.out.println(CountedDao.counted(2));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
		
}
	
	

