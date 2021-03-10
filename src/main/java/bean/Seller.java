package bean;

import org.springframework.web.multipart.MultipartFile;

public class Seller {

	private String sell_Email;
	
	private String sell_PW;
	
	private String sell_Name;
	
	private String sell_Contact;
	
	private String sell_Zipcode;
	
	private String sell_ADR01;
	
	private String sell_ADR02;
	
	private String sell_Pic;

	private String sell_Join;
	
    private long sell_License;
    
    private String sell_Status;
    
    private String remark;
    
	private MultipartFile img ;	

	public MultipartFile getImg() {
		return img;
	}

	public void setImg(MultipartFile img) {
		this.img = img;
		if (this.img != null) {
			this.sell_Pic = this.img.getOriginalFilename();
		}
	}
    
	public String getSell_Email() {
		return sell_Email;
	}
	public void setSell_Email(String sell_Email) {
		this.sell_Email = sell_Email;
	}
	public String getSell_PW() {
		return sell_PW;
	}
	public void setSell_PW(String sell_PW) {
		this.sell_PW = sell_PW;
	}
	public String getSell_Name() {
		return sell_Name;
	}
	public void setSell_Name(String sell_Name) {
		this.sell_Name = sell_Name;
	}
	public String getSell_Contact() {
		return sell_Contact;
	}
	public void setSell_Contact(String sell_Contact) {
		this.sell_Contact = sell_Contact;
	}
	public String getSell_Zipcode() {
		return sell_Zipcode;
	}
	public void setSell_Zipcode(String sell_Zipcode) {
		this.sell_Zipcode = sell_Zipcode;
	}
	public String getSell_ADR01() {
		return sell_ADR01;
	}
	public void setSell_ADR01(String sell_ADR01) {
		this.sell_ADR01 = sell_ADR01;
	}
	public String getSell_ADR02() {
		return sell_ADR02;
	}
	public void setSell_ADR02(String sell_ADR02) {
		this.sell_ADR02 = sell_ADR02;
	}
	public String getSell_Pic() {
		return sell_Pic;
	}
	public void setSell_Pic(String sell_Pic) {
		this.sell_Pic = sell_Pic;
	}
	public String getSell_Join() {
		return sell_Join;
	}
	public void setSell_Join(String sell_Join) {
		this.sell_Join = sell_Join;
	}
	public long getSell_License() {
		return sell_License;
	}
	public void setSell_License(long sell_License) {
		this.sell_License = (long) sell_License;
	}
	public String getSell_Status() {
		return sell_Status;
	}
	public void setSell_Status(String sell_Status) {
		this.sell_Status = sell_Status;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	@Override
	public String toString() {
		return "Seller [sell_Email=" + sell_Email + ", sell_PW=" + sell_PW + ", sell_Name=" + sell_Name
				+ ", sell_Contact=" + sell_Contact + ", sell_Zipcode=" + sell_Zipcode + ", sell_ADR01=" + sell_ADR01
				+ ", sell_ADR02=" + sell_ADR02 + ", sell_Pic=" + sell_Pic + ", sell_Join=" + sell_Join
				+ ", sell_License=" + sell_License + ", sell_Status=" + sell_Status + ", remark=" + remark + ", img="
				+ img + "]";
	}
	
    public Seller() {
		// TODO Auto-generated constructor stub
	}
    
}