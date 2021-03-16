package bean;

import org.springframework.web.multipart.MultipartFile;

public class Customer {
	private final String MUST_INPUT = "필수 입력 사항입니다.";
	
	private String cust_Email;
	
	private String cust_PW;
	
	private String cust_Name;
	
	private String cust_Contact;
	
	private String cust_Birth;
	
	private String cust_Zipcode;
	
	private String cust_ADR01;
	
	private String cust_ADR02;
	
	private String cust_Pic;
	
	private String cust_RegDate;
	
	private String cust_Join;
	
	private String remark;
		
	private MultipartFile img ;	

	public MultipartFile getImg() {
		return img;
	}

	public void setImg(MultipartFile img) {
		this.img = img;
		if (this.img != null) {
			this.cust_Pic = this.img.getOriginalFilename();
		}
	}
	
	public String getCust_Email() {
		return cust_Email;
	}
	public void setCust_Email(String cust_Email) {
		this.cust_Email = cust_Email;
	}
	public String getCust_PW() {
		return cust_PW;
	}
	public void setCust_PW(String cust_PW) {
		this.cust_PW = cust_PW;
	}
	public String getCust_Name() {
		return cust_Name;
	}
	public void setCust_Name(String cust_Name) {
		this.cust_Name = cust_Name;
	}
	public String getCust_Contact() {
		return cust_Contact;
	}
	public void setCust_Contact(String cust_Contact) {
		this.cust_Contact = cust_Contact;
	}
	public String getCust_Birth() {
		return cust_Birth;
	}
	public void setCust_Birth(String cust_Birth) {
		this.cust_Birth = cust_Birth;
	}
	public String getCust_Zipcode() {
		return cust_Zipcode;
	}
	public void setCust_Zipcode(String cust_Zipcode) {
		this.cust_Zipcode = cust_Zipcode;
	}
	public String getCust_ADR01() {
		return cust_ADR01;
	}
	public void setCust_ADR01(String cust_ADR01) {
		this.cust_ADR01 = cust_ADR01;
	}
	public String getCust_ADR02() {
		return cust_ADR02;
	}
	public void setCust_ADR02(String cust_ADR02) {
		this.cust_ADR02 = cust_ADR02;
	}
	public String getCust_Pic() {
		return cust_Pic;
	}
	public void setCust_Pic(String cust_Pic) {
		this.cust_Pic = cust_Pic;
	}
	public String getCust_RegDate() {
		return cust_RegDate;
	}
	public void setCust_RegDate(String cust_RegDate) {
		this.cust_RegDate = cust_RegDate;
	}
	public String getCust_Join() {
		return cust_Join;
	}
	public void setCust_Join(String cust_Join) {
		this.cust_Join = cust_Join;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getMUST_INPUT() {
		return MUST_INPUT;
	}
	
	
	@Override
	public String toString() {
		return "Customer [MUST_INPUT=" + MUST_INPUT + ", cust_Email=" + cust_Email + ", cust_PW=" + cust_PW
				+ ", cust_Name=" + cust_Name + ", cust_Contact=" + cust_Contact + ", cust_Birth=" + cust_Birth
				+ ", cust_Zipcode=" + cust_Zipcode + ", cust_ADR01=" + cust_ADR01 + ", cust_ADR02=" + cust_ADR02
				+ ", cust_Pic=" + cust_Pic + ", cust_RegDate=" + cust_RegDate + ", cust_Join=" + cust_Join + ", remark="
				+ remark + "]";
	}
	
	
	public Customer() {
		// TODO Auto-generated constructor stub
	}

	

}