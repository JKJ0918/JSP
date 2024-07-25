package memberShip;

public class MemberDTO {
	// member 객체
	
	//필드
	
	private String id;
	private String pass;
	private String name;
	private String regdate;
	
	
	
	public MemberDTO() {} // 기본생성자
	
	
	

	public String getId() {
		return id;
	}

	public String getPass() {
		return pass;
	}

	public String getName() {
		return name;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setPass(String pass) {
		this.pass = pass;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	
	
	
	
}
