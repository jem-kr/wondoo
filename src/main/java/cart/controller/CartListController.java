package cart.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bean.Cart;
import bean.Customer;
import bean.Product;
import common.controller.SuperClass;
import dao.CartDao;
import dao.CustomerDao;
import dao.ProductDao;

@Controller
public class CartListController extends SuperClass {
	private final String command = "/caList.ca"; // 요청 커맨드
	private final String redirect = "redirect:/xxx.me"; // 리다이렉션

	private ModelAndView mav = null; // 뷰에 넘겨 줄 ModelAndView 객체

	@Autowired
	@Qualifier("cdao")
	private CustomerDao cdao;

	@Autowired
	@Qualifier("productDao")
	private ProductDao productDao;

	@Autowired
	@Qualifier("cartDao")
	private CartDao cartDao;

	@ModelAttribute("cart")
	public Cart some() {
		return new Cart();
	}

	public CartListController() {
		super("cartList", null); // super(getpage, postpage)
		this.mav = new ModelAndView();
	}

	@GetMapping(command)
	public ModelAndView doGet(@RequestParam(value = "cart_cust_email", required = true) String cart_cust_email,
			HttpServletRequest request) {
		HttpSession session = request.getSession(); // 에러메세지를 담는 영역

		// 회원 이메일로 장바구니 목록 담기
		List<Cart> lists = this.cartDao.SelectAllData(cart_cust_email);
		
		// list 컬렉션에 담긴 상품 전체 금액
		int sum_price = 0;

		// 배송비 금액
		// 배송비 기준 30,000원 미만 2500원 30,000원 이상 0원
		int delivery_price = 0;
		
		if (lists.size() > 0) { // 장바구니 내역이 있으면
			
			Product product ;
			
			for (Cart cart : lists) { // 확장 for문을 돌리면서 필요한 상품 정보 셋팅
				product = this.productDao.SelectOneData(cart.getCart_pro_no());
				cart.setPro_name(product.getPro_name());
				cart.setPro_pic(product.getPro_pic());
				cart.setPro_stock(product.getPro_stock());
				cart.setPro_price(product.getPro_price());
				
				sum_price += cart.getCart_price();
			}
			
			this.mav.addObject("sum_price",sum_price); // 회원이 장바구니에 담아놓은 상품 총 가격
			
			if (sum_price >= 30000) { // 상품 총 가격이 3만원 이상이면 배송비 무료
				delivery_price = 0;
			}else { // 미만이면 2500원 
				delivery_price = 2500;
			}
			
			this.mav.addObject("delivery_price", delivery_price); // 배송비 
			this.mav.addObject("lists", lists); // 장바구니 목록
			session.setAttribute("cartlists", lists); // lists -> 현지 "cartlists"로 수정
			this.mav.addObject("total_list", lists.size()); // 장바구니 갯수

			// 회원 정보
			Customer customer = this.cdao.SelectDataByPk(cart_cust_email);
			this.mav.addObject("customer", customer);

			this.mav.setViewName(super.getpage);
		} else {
			session.setAttribute("message", "장바구니 내역이 없습니다. <br> 상품을 구매해보세요!");
			this.mav.setViewName("redirect:/main.co");
		}

		return this.mav;
	}

}
