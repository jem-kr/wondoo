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
// 회원탈퇴를 진행하는 컨트롤러입니다.
@Controller
public class CustDelController extends SuperClass{
	private final String command = "/custDel.cu" ; 
	private final String redirect = "redirect:/main.co" ;
	
	// 뷰에 넘겨줄 ModelAndView 객체
	private ModelAndView mav = null ; 
	
	@Autowired
	@Qualifier("cdao")
	private CustomerDao cdao ;
	
	public CustDelController() {
		// (변경 요망)
		super("custDel", null);
		this.mav = new ModelAndView();
	}
	
	@GetMapping(command)
	public ModelAndView doGet(
		@RequestParam(value = "cust_Email", required = true) String cust_Email,
		HttpSession session) {
		// 회원 이메일(cust_Email)을 통해 회원 정보 1건을 가져옵니다. 
		Customer bean = this.cdao.SelectDataByPk(cust_Email) ;
		
		int cnt = -99999 ;
		// 회원테이블에서 해당 회원의 데이터를 삭제합니다.
		cnt = this.cdao.DeleteData(bean) ;
		
		// 탈퇴하는 사람에 대한 세션 정보를 완전히 비웁니다.
		session.invalidate();
		this.mav.setViewName(this.redirect); 
		return this.mav ;
	}
	
}