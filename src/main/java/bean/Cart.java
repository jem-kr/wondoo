package bean;

public class Cart {
	private int cart_seq; // 장바구니 인덱스
	private int cart_pro_no; // 상품 번호
	private int cart_cust_qty; // 회원이 선택한 상품수량
	private String cart_cust_email; // 회원 이메일
	private String cart_sell_email; // 사업자 이메일
	private int cart_total_price; // 총 가격

	// 장바구니 목록에 필요한 변수 → DB접근 안함
	private String pro_name; // 상품 이름
	private String pro_pic; // 상품 사진

	// 장바구니 목록에서 수량 선택 시 필요한 변수 → DB접근 안함
	private int pro_stock; // 사업자가 설정한 최대 상품수
	private int pro_price; // 사업자가 설정한 개 당 가격

	public Cart() {
	}

	public int getPro_stock() {
		return pro_stock;
	}

	public void setPro_stock(int pro_stock) {
		this.pro_stock = pro_stock;
	}

	public int getPro_price() {
		return pro_price;
	}

	public void setPro_price(int pro_price) {
		this.pro_price = pro_price;
	}

	public String getPro_name() {
		return pro_name;
	}

	public void setPro_name(String pro_name) {
		this.pro_name = pro_name;
	}

	public String getPro_pic() {
		return pro_pic;
	}

	public void setPro_pic(String pro_pic) {
		this.pro_pic = pro_pic;
	}

	public int getCart_seq() {
		return cart_seq;
	}

	public void setCart_seq(int cart_seq) {
		this.cart_seq = cart_seq;
	}

	public int getCart_pro_no() {
		return cart_pro_no;
	}

	public void setCart_pro_no(int cart_pro_no) {
		this.cart_pro_no = cart_pro_no;
	}

	public int getCart_cust_qty() {
		return cart_cust_qty;
	}

	public void setCart_cust_qty(int cart_cust_qty) {
		this.cart_cust_qty = cart_cust_qty;
	}

	public String getCart_cust_email() {
		return cart_cust_email;
	}

	public void setCart_cust_email(String cart_cust_email) {
		this.cart_cust_email = cart_cust_email;
	}

	public String getCart_sell_email() {
		return cart_sell_email;
	}

	public void setCart_sell_email(String cart_sell_email) {
		this.cart_sell_email = cart_sell_email;
	}

	public int getCart_total_price() {
		return cart_total_price;
	}

	public void setCart_total_price(int cart_total_price) {
		this.cart_total_price = cart_total_price;
	}

	@Override
	public String toString() {
		return "Cart [cart_seq=" + cart_seq + ", cart_pro_no=" + cart_pro_no + ", cart_cust_qty=" + cart_cust_qty
				+ ", cart_cust_email=" + cart_cust_email + ", cart_sell_email=" + cart_sell_email
				+ ", cart_total_price=" + cart_total_price + ", pro_name=" + pro_name + ", pro_pic=" + pro_pic
				+ ", pro_stock=" + pro_stock + ", pro_price=" + pro_price + "]";
	}

}
