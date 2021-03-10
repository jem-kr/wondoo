package bean;

// 회원이 결제할때 저장되는 빈 클래스(원데이클래스 결제 정보 클래스)
public class OnedayOrder {

	private int onedayorder_seq; // 시퀀스
	private String cust_email; // 회원 이메일
	private String code; // 상품 코드
	private String sell_email; // 사업자 이메일
	private String bookdate; // 예약 일자
	private String booktime; // 예약 시간
	private int person; // 예약한 인원수
	private int totalprice; // 총 결제 금액
	private String realtime; // 실 결제 시간
	private String remark; // 비고

	// 회원용 결제 내역에 보여주는 변수
	private String main_image; // 메인 이미지
	private String classname; // 클래스 이름

	// 사업자용 결제 상세에 보여주는 변수
	private String cust_name; // 회원 이름
	private String cust_contact; // 회원 연락처

	public OnedayOrder() {
	}

	public String getMain_image() {
		return main_image;
	}

	public void setMain_image(String main_image) {
		this.main_image = main_image;
	}

	public String getClassname() {
		return classname;
	}

	public void setClassname(String classname) {
		this.classname = classname;
	}

	public String getCust_name() {
		return cust_name;
	}

	public void setCust_name(String cust_name) {
		this.cust_name = cust_name;
	}

	public String getCust_contact() {
		return cust_contact;
	}

	public void setCust_contact(String cust_contact) {
		this.cust_contact = cust_contact;
	}

	public int getOnedayorder_seq() {
		return onedayorder_seq;
	}

	public void setOnedayorder_seq(int onedayorder_seq) {
		this.onedayorder_seq = onedayorder_seq;
	}

	public String getCust_email() {
		return cust_email;
	}

	public void setCust_email(String cust_email) {
		this.cust_email = cust_email;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getSell_email() {
		return sell_email;
	}

	public void setSell_email(String sell_email) {
		this.sell_email = sell_email;
	}

	public String getBookdate() {
		return bookdate;
	}

	public void setBookdate(String bookdate) {
		this.bookdate = bookdate;
	}

	public String getBooktime() {
		return booktime;
	}

	public void setBooktime(String booktime) {
		this.booktime = booktime;
	}

	public int getPerson() {
		return person;
	}

	public void setPerson(int person) {
		this.person = person;
	}

	public int getTotalprice() {
		return totalprice;
	}

	public void setTotalprice(int totalprice) {
		this.totalprice = totalprice;
	}

	public String getRealtime() {
		return realtime;
	}

	public void setRealtime(String realtime) {
		this.realtime = realtime;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Override
	public String toString() {
		return "OnedayOrder [onedayorder_seq=" + onedayorder_seq + ", cust_email=" + cust_email + ", code=" + code
				+ ", sell_email=" + sell_email + ", bookdate=" + bookdate + ", booktime=" + booktime + ", person="
				+ person + ", totalprice=" + totalprice + ", realtime=" + realtime + ", remark=" + remark
				+ ", main_image=" + main_image + ", classname=" + classname + "]";
	}

}
