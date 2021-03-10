package onedayClass.controller;

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
import bean.OnedayClass;
import bean.OnedayOrder;
import common.controller.SuperClass;
import dao.OnedayClassDao;
import dao.OnedayOrderDao;

@Controller
public class OnedayClassCustomerOrderdetailController extends SuperClass{
	private final String command = "/onedayCustOrderDetail.odc"; //  요청 커맨드
	private final String redirect = "redirect:/xxx.odc"; // 리다이렉션
	
	private ModelAndView mav = null;
	
	@Autowired
	@Qualifier(value = "onedayDao")
	private OnedayClassDao onedayDao;
	
	@Autowired
	@Qualifier(value = "orderDao")
	private OnedayOrderDao orderDao;
	
	public OnedayClassCustomerOrderdetailController() {
		super("oneday_CustOrderDetail", ""); // super(getpage , postpage)
		this.mav = new ModelAndView();
	}

	@GetMapping(value = command)
	public ModelAndView doGet(
			@RequestParam (value="onedayorder_seq" , required = true) int onedayorder_seq,
			@RequestParam(value = "pageNumber", required = false)String pageNumber,
			@RequestParam(value = "pageSize", required = false)String pageSize,
			@RequestParam(value = "mode", required = false)String mode,
			@RequestParam(value = "keyword", required = false)String keyword,	
			HttpServletRequest request
			) {
		
		HttpSession session = request.getSession();
		Customer customer = (Customer)session.getAttribute("loginfo"); 
		
		OnedayOrder bean = this.orderDao.SelectOneData(onedayorder_seq);
		
		if (bean != null) {
			System.out.println("회원 결제 상세보기 성공");
			
			// 클래스 코드 값을 이용하여 원데이 클래스 정보 가져오기 --> JSP 단에서 보여줘야함 
			OnedayClass oneday_bean = this.onedayDao.SelectOneData(bean.getCode());
			mav.addObject("oneday_bean", oneday_bean);
			
			// 원데이 클래스 결제 테이블 
			mav.addObject("bean", bean);
			
			// 회원 정보 테이블 
			mav.addObject("customer", customer);
			
			mav.setViewName(super.getpage);
		}else {
			System.out.println("회원 결제 상세보기 실패");
			mav.setViewName("redirect:/onedayCustOrderList.odc?cust_email=" + customer.getCust_Email());
		}
		
		
		return mav;
	}
	
	@PostMapping(value = command)
	public ModelAndView doPost() {
		
		this.mav.setViewName(super.postpage);
		return this.mav;
	}
}
