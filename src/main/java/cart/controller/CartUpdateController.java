package cart.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import bean.Cart;
import bean.Customer;
import bean.Product;
import common.controller.SuperClass;
import customer.controller.CustLoginController;
import dao.CartDao;
import dao.OnedayOrderDao;
import dao.ProductDao;
import oracle.net.aso.i;

@Controller
public class CartUpdateController extends SuperClass {
	private final String command = "/caUpdate.ca";
	private final String redirect = "redirect:/xxx.me"; // 리다이렉션

	private ModelAndView mav = null; // 뷰에 넘겨 줄 ModelAndView 객체

	@Autowired
	@Qualifier("productDao")
	private ProductDao productDao;

	@Autowired
	@Qualifier("cartDao")
	private CartDao cartDao;

	public CartUpdateController() {
		super(null, null); // super(getpage, postpage)
		this.mav = new ModelAndView();
	}

	@GetMapping(command)
	@ResponseBody
	public String doGet(@RequestParam(value = "cart_seq") int cart_seq,
			@RequestParam(value = "orders_pro_no") int orders_pro_no, @RequestParam(value = "new_qty") int new_qty,
			HttpServletRequest request) {

		HttpSession session = request.getSession();
		Customer customer = (Customer) session.getAttribute("loginfo"); // 회원 정보

		String result = "";
		if (customer != null) {

			Product product = this.productDao.SelectOneData(orders_pro_no); // 상품 정보

			Cart cart = this.cartDao.SelectOneData(cart_seq); // 장바구니 정보

			int pro_stock = product.getPro_stock(); // 사업자가 초기 설정한 재고

			

			if (new_qty > pro_stock) {
				// 초기 설정한 재고 max 값을 초과하면 에러 메세지를 팝업
				// 수량 + 처리 시 사용되는 조건문
				result = "over";
			} else if (new_qty == 0) {
				// 새로 설정한 수량 값이 0이 되었을 때 에러 메세지를 팝업
				// 수량 - 처리 시 사용되는 조건문

				result = "zero";

			} else {
				// 수량 + : 초기 설정한 재고 max 값 이하이면 장바구니 테이블 update 처리
				// 수량 - : 새로 설정한 수량 값이 0이 아닐때 update 처리
				int cnt = -1;

				int new_price = product.getPro_price() * new_qty; // 신규 금액

				cnt = this.cartDao.UpdateQtyPrice(cart_seq, new_qty, new_price, customer.getCust_Email());

				if (cnt > 0) {
					System.out.println("상품 수량 , 금액 업데이트 성공");
					result = "success";
				} else {
					System.out.println("상품 수량 , 금액 업데이트 실패");
					result = "fail";
				}

			}
		}else {
			session.setAttribute("message", "로그인을 먼저 해주세요!");
			result = "login";
		}
		return result;
	}

}
