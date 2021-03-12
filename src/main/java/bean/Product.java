package bean;

import org.springframework.web.multipart.MultipartFile;

public class Product {
	private int products_seq;
	private String pro_type;
	private String pro_name;
	private int pro_price;
	private int pro_stock;
	private String pro_detail;
	private String pro_origin;
	private String pro_sell_email;
	private String pro_pic;
	private String pro_category;
	
	private MultipartFile p_img;
	
	
	
	public MultipartFile getP_img() {
		return p_img;
	}


	public void setP_img(MultipartFile p_img) {
		this.p_img = p_img;
		if (this.p_img != null) {
			this.pro_pic = this.p_img.getOriginalFilename();
		}
	}
	


	public int getProducts_seq() {
		return products_seq;
	}


	public void setProducts_seq(int products_seq) {
		this.products_seq = products_seq;
	}


	public String getPro_type() {
		return pro_type;
	}


	public void setPro_type(String pro_type) {
		this.pro_type = pro_type;
	}


	public String getPro_name() {
		return pro_name;
	}


	public void setPro_name(String pro_name) {
		this.pro_name = pro_name;
	}


	public int getPro_price() {
		return pro_price;
	}


	public void setPro_price(int pro_price) {
		this.pro_price = pro_price;
	}


	public int getPro_stock() {
		return pro_stock;
	}


	public void setPro_stock(int pro_stock) {
		this.pro_stock = pro_stock;
	}


	public String getPro_detail() {
		return pro_detail;
	}


	public void setPro_detail(String pro_detail) {
		this.pro_detail = pro_detail;
	}


	public String getPro_origin() {
		return pro_origin;
	}


	public void setPro_origin(String pro_origin) {
		this.pro_origin = pro_origin;
	}


	public String getPro_sell_email() {
		return pro_sell_email;
	}


	public void setPro_sell_email(String pro_sell_email) {
		this.pro_sell_email = pro_sell_email;
	}


	public String getPro_pic() {
		return pro_pic;
	}


	public void setPro_pic(String pro_pic) {
		this.pro_pic = pro_pic;
	}
	
	

	public String getPro_category() {
		return pro_category;
	}


	public void setPro_category(String pro_category) {
		this.pro_category = pro_category;
	}

	
	@Override
	public String toString() {
		return "Product [products_seq=" + products_seq + ", pro_type=" + pro_type + ", pro_name=" + pro_name
				+ ", pro_price=" + pro_price + ", pro_stock=" + pro_stock + ", pro_detail=" + pro_detail
				+ ", pro_origin=" + pro_origin + ", pro_sell_email=" + pro_sell_email + ", pro_pic=" + pro_pic
				+ ", pro_category=" + pro_category + "]";
	}


	public Product() {
		// TODO Auto-generated constructor stub
	}
}
