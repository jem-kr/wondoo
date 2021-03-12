package product.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bean.OnedayClass;
import bean.Product;
import bean.Seller;
import common.controller.SuperClass;
import dao.OnedayClassDao;
import dao.ProductDao;
import dao.SellerDao;

@Controller
public class ProductDetailViewController extends SuperClass {
	private final String command = "/prDetail.pr"; // 요청 커맨드
	private final String redirect = "redirect:/main.co"; // 리다이렉션

	private ModelAndView mav = null;

	@Autowired
	@Qualifier(value = "productDao")
	private ProductDao dao;
	
	// 사업자 정보를 가져오기 위해 seller dao 클래스를 선언 
	@Autowired
	@Qualifier(value = "sdao")
	private SellerDao sdao;

	public ProductDetailViewController() {
		super("productDetail", ""); // super(getpage , postpage)
		this.mav = new ModelAndView();
	}

	@GetMapping(value = command)
	public ModelAndView doGet(@RequestParam(value = "products_seq", required = true) int products_seq) {
		Product bean = this.dao.SelectOneData(products_seq);

		
		if(bean != null) {
			System.out.println("상품 bean 객체 발견");
			// 상호명을 jsp 에서 보여줘야함 
			Seller seller = this.sdao.SelectDataByPk(bean.getPro_sell_email());
			System.out.println("사업자 정보 : " + seller.toString());
			
			mav.addObject("seller", seller);
			
			// 이용 시간 부분
			
			mav.addObject("bean", bean);
			mav.setViewName(super.getpage);
		}else {
			System.out.println("상품 bean 객체 미발견");
			mav.setViewName(redirect);
		}
		
		return mav;
	}

	@PostMapping(value = command)
	public ModelAndView doPost() {

		this.mav.setViewName(super.postpage);
		return this.mav;
	}
}
