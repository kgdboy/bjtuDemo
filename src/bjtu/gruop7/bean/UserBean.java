package bjtu.gruop7.bean;

public class UserBean {
	private int		id                    ;
	private String  login_name			  ;
	private String  login_pass			  ;
	private String	orga_name             ;
	private String	depart_name           ;
	private String	name                  ;
	private String	nation	              ;
	private String  duty				  ;
	private String	salary_number         ;
	private String  tel					  ;
	private String	identity_num          ;
	private String	lev                   ;
	private int		virtual_account       ;

	public UserBean() {
		// TODO 自动生成的构造函数存根
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	
	public String getLogin_name() {
		return login_name;
	}

	public void setLogin_name(String login_name) {
		this.login_name = login_name;
	}

	public String getLogin_pass() {
		return login_pass;
	}

	public void setLogin_pass(String login_pass) {
		this.login_pass = login_pass;
	}

	public String getOrga_name() {
		return orga_name;
	}

	public void setOrga_name(String orga_name) {
		this.orga_name = orga_name;
	}

	public String getDepart_name() {
		return depart_name;
	}

	public void setDepart_name(String depart_name) {
		this.depart_name = depart_name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNation() {
		return nation;
	}

	public void setNation(String nation) {
		this.nation = nation;
	}
	
	public String getDuty() {
		return duty;
	}

	public void setDuty(String duty) {
		this.duty = duty;
	}

	public String getSalary_number() {
		return salary_number;
	}

	public void setSalary_number(String salary_number) {
		this.salary_number = salary_number;
	}
	
	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getIdentity_num() {
		return identity_num;
	}

	public void setIdentity_num(String identity_num) {
		this.identity_num = identity_num;
	}

	public String getLev() {
		return lev;
	}

	public void setLev(String lev) {
		this.lev = lev;
	}

	public int getVirtual_account() {
		return virtual_account;
	}

	public void setVirtual_account(int virtual_account) {
		this.virtual_account = virtual_account;
	}

	@Override
	public String toString() {
		return "UserBean [id=" + id + ", login_name=" + login_name + ", login_pass=" + login_pass + ", orga_name="
				+ orga_name + ", depart_name=" + depart_name + ", name=" + name + ", nation=" + nation + ", duty="
				+ duty + ", salary_number=" + salary_number + ", tel=" + tel + ", identity_num=" + identity_num
				+ ", lev=" + lev + ", virtual_account=" + virtual_account + "]";
	}
	
}
