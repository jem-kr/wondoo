package bean;

public class Order {
	// 변수 선언
	private int orders_seq;
	private int orders_pro_no;	
	private String orders_zipcode;
	private String orders_adr01;
	private String orders_adr02;
	private String orders_cust_email; 
	private String orders_request;
	private String orders_realtime;	
	private int orders_amount;
	private int orders_qty;
	private String orders_phone;	
	private String remark;
	
	// getter & setter
	public int getOrders_seq() {
		return orders_seq;
	}
	public void setOrders_seq(int orders_seq) {
		this.orders_seq = orders_seq;
	}
	public int getOrders_pro_no() {
		return orders_pro_no;
	}
	public void setOrders_pro_no(int orders_pro_no) {
		this.orders_pro_no = orders_pro_no;
	}
	public String getOrders_zipcode() {
		return orders_zipcode;
	}
	public void setOrders_zipcode(String orders_zipcode) {
		this.orders_zipcode = orders_zipcode;
	}
	public String getOrders_adr01() {
		return orders_adr01;
	}
	public void setOrders_adr01(String orders_adr01) {
		this.orders_adr01 = orders_adr01;
	}
	public String getOrders_adr02() {
		return orders_adr02;
	}
	public void setOrders_adr02(String orders_adr02) {
		this.orders_adr02 = orders_adr02;
	}
	public String getOrders_cust_email() {
		return orders_cust_email;
	}
	public void setOrders_cust_email(String orders_cust_email) {
		this.orders_cust_email = orders_cust_email;
	}
	public String getOrders_request() {
		return orders_request;
	}
	public void setOrders_request(String orders_request) {
		this.orders_request = orders_request;
	}
	public String getOrders_realtime() {
		return orders_realtime;
	}
	public void setOrders_realtime(String orders_realtime) {
		this.orders_realtime = orders_realtime;
	}
	public int getOrders_amount() {
		return orders_amount;
	}
	public void setOrders_amount(int orders_amount) {
		this.orders_amount = orders_amount;
	}
	public int getOrders_qty() {
		return orders_qty;
	}
	public void setOrders_qty(int orders_qty) {
		this.orders_qty = orders_qty;
	}
	public String getOrders_phone() {
		return orders_phone;
	}
	public void setOrders_phone(String orders_phone) {
		this.orders_phone = orders_phone;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	// toString
	@Override
	public String toString() {
		return "Order [orders_seq=" + orders_seq + ", orders_pro_no=" + orders_pro_no + ", orders_zipcode="
				+ orders_zipcode + ", orders_adr01=" + orders_adr01 + ", orders_adr02=" + orders_adr02
				+ ", orders_cust_email=" + orders_cust_email + ", orders_request=" + orders_request
				+ ", orders_realtime=" + orders_realtime + ", orders_amount=" + orders_amount + ", orders_qty="
				+ orders_qty + ", orders_phone=" + orders_phone + ", remark=" + remark + "]";
	}	
	
	public Order() {

	}
	
}


