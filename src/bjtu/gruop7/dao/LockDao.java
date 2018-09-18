package bjtu.gruop7.dao;

import java.util.ArrayList;

public class LockDao {

	public Boolean requestLock(String lock) {
		bjtu.gruop7.util.SqlHelper sqlHelper = new bjtu.gruop7.util.SqlHelper();
		String[] str = { lock};
		int a = sqlHelper
				.executeUpdate("update info_lock set islock=?",str);
		if(a>0){
			return true;
		}else {
			return false;
		}
	}

	public Boolean queryLockstatus(String i) {
		bjtu.gruop7.util.SqlHelper sqlHelper = new bjtu.gruop7.util.SqlHelper();
		String[] str = {i};
		ArrayList<String[]> arrayList = sqlHelper
				.executeQuery("select islock from info_lock where id=?",str);
		if (arrayList.size() > 0) {
			if("0".equals(arrayList.get(0)[0])){
				return false;
			}else if("1".equals(arrayList.get(0)[0])){
				return true;
			}
		}
		return null;
	}
}