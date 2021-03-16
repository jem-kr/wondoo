package cart.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bean.Customer;
import common.controller.SuperClass;
import dao.CartDao;
import dao.OnedayOrderDao;


@Controller
public class CartDeleteController extends SuperClass{
	private final String command = "/caDelete.ca"; // 요청 커맨드(변경 요망)
	private final String redirect = "redirect:/xxx.me"; // 리다이렉션
	
	private ModelAndView mav = null; // 뷰에 넘겨 줄 ModelAndView 객체
	
	@Autowired
	@Qualifier("cartDao")//(변경 요망)
	private CartDao cartDao ;
	
	public CartDeleteController() {
		super(null, null); // super(getpage, postpage)
		this.mav = new ModelAndView();
	}
	
	@GetMapping(command)
	public ModelAndView doGet(
			@RequestParam(value = "cart_seq") int cart_seq,
			HttpServletRequest request
			) {
		HttpSession session = request.getSession();
		Customer customer = (Customer)session.getAttribute("loginfo");
		
		int cnt = -1;
		cnt = this.cartDao.DeleteData(cart_seq);
		
		if (cnt > 0) {// 장바구니 삭제 성공
			System.out.println("장바구니 삭제 성공");
			this.mav.setViewName("redirect:/caList.ca?cart_cust_email="+ customer.getCust_Email());
		}
		return this.mav;
	}
	
	@PostMapping(command)
	public ModelAndView doPost() {
		this.mav.setViewName(super.postpage);
		return this.mav;
	}

}
