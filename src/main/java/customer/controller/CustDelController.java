package customer.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bean.Customer;
import common.controller.SuperClass;
import dao.CustomerDao;

@Controller
public class CustDelController extends SuperClass{
	private final String command = "/custDel.cu" ; // 요청 커맨드(변경 요망)
	private final String redirect = "redirect:/main.co" ; // 리다이렉션(변경 요망)
	
	// 뷰에 넘겨줄 ModelAndView 객체
	private ModelAndView mav = null ; 
	
	@Autowired
	@Qualifier("cdao") // (변경 요망)
	private CustomerDao cdao ;// (변경 요망)
	
	public CustDelController() {
		// (변경 요망)
		super("custDel", null); // super(getpage, postpage)  
		this.mav = new ModelAndView();
	}
	
	@GetMapping(command)
	public ModelAndView doGet(
		@RequestParam(value = "cust_Email", required = true) String cust_Email,
		HttpSession session) {
		
		Customer bean = this.cdao.SelectDataByPk(cust_Email) ;
		
		int cnt = -99999 ;
		cnt = this.cdao.DeleteData(bean) ;
		
		
		// 탈퇴하는 사람에 대한 세션 정보를 완전히 비웁니다.
		session.invalidate();
		this.mav.setViewName(this.redirect); 
		return this.mav ;
	}
	
}