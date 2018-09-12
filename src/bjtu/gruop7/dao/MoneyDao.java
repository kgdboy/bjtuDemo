package bjtu.gruop7.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import bjtu.gruop7.util.JdbcUtils;
import bjtu.gruop7.util.SqlHelper;


public class MoneyDao {
	
	public MoneyDao() {
		super();
		// TODO Auto-generated constructor stub
	}
	/**
	 * 根据工资号返回余额
	 * 
	 * @param salary_number
	 * @return virtual_account
	 */
	public ArrayList<Object> getMoney(String salary_number) {
		// TODO 自动生成的方法存根
		ArrayList<Object> arr = new ArrayList<>();
		SqlHelper sqlHelper = new SqlHelper();
		String[] str = {salary_number};
		System.out.println(str[0]);//372683
		ArrayList<String[]> arrayList = sqlHelper.executeQuery("select * from info_user where salary_number=?",str);
		
			Connection conn = null;
		     PreparedStatement ps = null;
		     ResultSet rs = null;
		     JdbcUtils jdbcUtils = null;
		try{
			jdbcUtils= JdbcUtils.getInstance();
		conn = jdbcUtils.getConnection();
		ps = conn.prepareStatement("select * from info_user where salary_number=?");
		ps.setString(1, "378888");
		rs = ps.executeQuery();
		while (rs.next()) {
             System.out.println(rs.getString(0));
            }
             
        
	} catch (SQLException e) {
        e.printStackTrace();
//        JOptionPane.showMessageDialog(null,"数据库链接异常");
        throw new RuntimeException(e.getMessage());
    } finally {
        jdbcUtils.free(conn, ps, rs);
    }
		System.out.println("P>?"+arrayList.size());
	
		if (arrayList.size() > 0) {
			arr.add(0);
			arr.add("获取成功！");
		} else {
			arr.add(1);
			arr.add("获取失败！");
			
		}
//		arr.add(arrayList.get(0)[0]);
		return arr;

	}

}

