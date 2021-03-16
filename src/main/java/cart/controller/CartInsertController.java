package cart.controller;

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
import bean.Seller;
import common.controller.SuperClass;
import dao.CartDao;
import dao.ProductDao;

@Controller
public class CartInsertController extends SuperClass {
	private final String command = "/caInsert.ca"; // 요청 커맨드
	private final String redirect = ""; // 리다이렉션

	private ModelAndView mav = null; // 뷰에 넘겨 줄 ModelAndView 객체

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

	public CartInsertController() {
		super(null, null); // super(getpage, postpage)
		this.mav = new ModelAndView();
	}

	@GetMapping(command)
	public ModelAndView doGet(@RequestParam(value = "products_seq", required = true) int cart_pro_no,
			@RequestParam(value = "qty", required = true) int cart_cust_qty,
			@RequestParam(value = "totalprice", required = true) String cart_total_price, HttpServletRequest request) {
		// 회원일때만 상품 구매가 가능함
		// 조건 1. 사업자일 경우 → 상품 구매 불가
		// 조건 2. 비회원일 경우 → 상품 구매 불가
		// 조건 3. 일반회원이면서 관리자일 경우 → 상품 구매 불가

		// 에러 메세지를 담을 세션 영역 및 로그인 정보를 가져올 때 사용
		HttpSession session = request.getSession();// 에러 메세지를 담을 세션 영역
		// 로그인 한 사용자 정보
		Customer customer = (Customer) session.getAttribute("loginfo");

		// 로그인 한 사업자 정보
		Seller seller = (Seller) session.getAttribute("loginfo_seller");

		// 상품 정보
		Product product;
		if (customer != null || seller != null) { // 로그인이 되어 있다면
			if (seller != null) { // 사업자로 로그인 되어있다면
				session.setAttribute("message", "사업자는 상품을 구매할 수 없습니다!");
				mav.setViewName("redirect:/cfList.pr");
			}

			if (customer != null && customer.getCust_Email().equals("admin@gmail.com")) { // 관리자로 로그인 되어있다면
				session.setAttribute("message", "관리자는 상품을 구매할 수 없습니다!");
				mav.setViewName("redirect:/cfList.pr");
			} else if (customer != null && customer.getCust_Email().equals("admin@gmail.com") == false) {// 일반 회원이라면
				product = this.productDao.SelectOneData(cart_pro_no); // 상품 정보

				Cart bean = new Cart();
				bean.setCart_seq(0);
				bean.setCart_cust_email(customer.getCust_Email());
				bean.setCart_cust_qty(cart_cust_qty);
				bean.setCart_pro_no(cart_pro_no);
				bean.setCart_sell_email(product.getPro_sell_email());

				// 가격 콤마 제거
				int totalprice = Integer.parseInt(cart_total_price.replace(",", ""));
				bean.setCart_total_price(totalprice);

				int cnt = -1; // 초기화

				cnt = this.cartDao.InsertData(bean);
				
				if (cnt > 0) { // 장바구니 추가 완료
					System.out.println("장바구니 추가 완료");
					session.setAttribute("cart_modal", "success");
					this.mav.setViewName("redirect:/prDetail.pr?products_seq=" + cart_pro_no);
				}
			}

		} else { // 로그인이 되어있지 않으면
			session.setAttribute("message", "상품 구매 전 로그인을 먼저 해주세요!");
			mav.setViewName("redirect:/custLog.cu");

		}

		return this.mav;
	}

//	@PostMapping(command)
//	public ModelAndView doPost() {
//		this.mav.setViewName(super.postpage);
//		return this.mav;
//	}

}
