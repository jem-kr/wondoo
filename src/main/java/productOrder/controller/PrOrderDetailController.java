package productOrder.controller;

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
import bean.Product;
import bean.ProductOrder;
import common.controller.SuperClass;
import dao.ProductDao;
import dao.ProductOrderDao;


@Controller
public class PrOrderDetailController extends SuperClass{
	private final String command = "/prOrderDetail.po"; // 요청 커맨드(변경 요망)
	private final String redirect = "redirect:/xxx.me"; // 리다이렉션
	
	private ModelAndView mav = null; // 뷰에 넘겨 줄 ModelAndView 객체
	
	@Autowired
	@Qualifier("ProductOrderDao")//(변경 요망)
	private ProductOrderDao ProductOrderDao ;

	@Autowired
	@Qualifier("productDao")//(변경 요망)
	private ProductDao ProductDao ;
	
	
	public PrOrderDetailController() {
		//(변경 요망)
		super("prOrderDetail", null); // super(getpage, postpage)
		this.mav = new ModelAndView();
	}
	
	@GetMapping(command)
	public ModelAndView doGet(
			@RequestParam (value="orders_seq" , required = true) int orders_seq,
			@RequestParam(value = "pageNumber", required = false)String pageNumber,
			@RequestParam(value = "pageSize", required = false)String pageSize,
			@RequestParam(value = "mode", required = false)String mode,
			@RequestParam(value = "keyword", required = false)String keyword,	
			HttpServletRequest request			
			) {
		
		HttpSession session = request.getSession();
		Customer customer = (Customer)session.getAttribute("loginfo"); 
		
		ProductOrder bean = this.ProductOrderDao.SelectOneData(orders_seq);
		
		if (bean != null) {
			// 회원 결제 상세보기 성공
			System.out.println("상품 결제 상세보기 성공");
			
			// 상품 번호 값을 이용하여 상품 정보 가져오기 --> JSP 단에서 보여줘야함 
			Product product_bean = this.ProductDao.SelectOneData(bean.getOrders_pro_no());
			mav.addObject("product_bean", product_bean);
			
			// 상품 결제 테이블 
			mav.addObject("bean", bean);
			
			// 회원 정보 테이블 
			mav.addObject("customer", customer);
			
			mav.setViewName(super.getpage);
		}else {
			// 회원 결제 상세보기 실패
			System.out.println("회원 결제 상세보기 실패");
			mav.setViewName("redirect:/prOrderList.po?orders_cust_email=" + customer.getCust_Email());
		}
		
		return mav;
	}
	
	@PostMapping(command)
	public ModelAndView doPost() {
		this.mav.setViewName(super.postpage);
		return this.mav;
	}

}
