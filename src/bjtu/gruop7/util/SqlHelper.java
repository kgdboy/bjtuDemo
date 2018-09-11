package bjtu.gruop7.util;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;

 
public final class SqlHelper {
     
    //定义需要的变量
    private Connection conn = null;
    private PreparedStatement ps = null;
    private ResultSet rs = null;
     
    JdbcUtils jdbcUtils = JdbcUtils.getInstance();
     
    //该方法执行一个update/delete/insert语句
    //sql语句是带问号的格式，如：update table_name set column_name = ? where ...
    //parameters = {"...", "..."...}；
    public int executeUpdate(String sql, String[] parameters) {
    	int message=0;
            try {
                conn = jdbcUtils.getConnection();
                ps = conn.prepareStatement(sql);
                //给？赋值
                if (parameters != null) {
                    for (int i=0; i<parameters.length; i++) {
                        ps.setString(i+1, parameters[i]);
                    }
                }
                //执行语句
                message = ps.executeUpdate();
                return message;
            } catch (SQLException e) {
                e.printStackTrace();
                throw new RuntimeException(e.getMessage());
            } finally {
                //关闭资源
                jdbcUtils.free(conn, ps, rs);
            }
    }
     
    //可以执行多个update、delete、insert语句（考虑事务）
    public void executeUpdate(String[] sqls, String[][] parameters) {
        try {
            //得到连接
            conn = jdbcUtils.getConnection();
            //多个sql语句，考虑事务
            conn.setAutoCommit(false);
             
            for (int i=0; i<sqls.length; i++) {
                if (parameters[i] != null) {
                    ps = conn.prepareStatement(sqls[i]);
                     
                    for (int j=0; j<parameters[i].length; j++) {
                        ps.setString(j+1, parameters[i][j]);
                    }
                     
                    ps.executeUpdate();
                }
 
            }
             
            conn.commit();
        } catch (SQLException e) {
            //回滚
            try {
                conn.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        } finally {
            jdbcUtils.free(conn, ps, rs);
        }
    }
     
        //统一的select语句，为了能够访问结果集，将结果集放入ArrayList，这样可以直接关闭资源
    @SuppressWarnings({ "rawtypes", "unchecked" })
    public ArrayList<String[]> executeQuery(String sql, String[] parameters) {
        ArrayList results = new ArrayList();
         
        try {
            conn = jdbcUtils.getConnection();
            ps = conn.prepareStatement(sql);
             
            if (parameters != null) {
                for (int i=0; i<parameters.length; i++) {
                    ps.setString(i+1, parameters[i]);
                }
            }
             
            rs = ps.executeQuery();
             
            ResultSetMetaData rsmd = rs.getMetaData();
            int column = rsmd.getColumnCount();
             
            while (rs.next()) {
                String[] str = new String[column];
                 
                for (int i=1; i<=column; i++) {
                    str[i-1] = rs.getString(i);
                }
                 
                results.add(str);
            }
        } catch (SQLException e) {
            e.printStackTrace();
//            JOptionPane.showMessageDialog(null,"数据库链接异常");
            throw new RuntimeException(e.getMessage());
        } finally {
            jdbcUtils.free(conn, ps, rs);
        }
        return results; 
    }
     
}