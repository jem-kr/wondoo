package customer.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bean.Customer;
import common.controller.SuperClass;
import dao.CustomerDao;
// 회원 정보 상세에 대한 컨트롤러입니다.
@Controller
public class CustDetailController extends SuperClass {
	private final String command = "/custDetail.cu" ;
	private final String redirect = "redirect:/xxx.me" ;
	
	private ModelAndView mav = null ; 
	
	@Autowired
	@Qualifier("cdao") 
	private CustomerDao cdao ;
	
	public CustDetailController() {
		super("custDetail", null);
		this.mav = new ModelAndView();
	}
	
	@GetMapping(command)
	public ModelAndView doGet(
		@RequestParam(value = "cust_Email", required = false) String cust_Email) {
		// 회원 이메일(cust_Email)을 통해 회원 정보 1건을 가져옵니다. 
		Customer bean = this.cdao.SelectDataByPk(cust_Email) ;
		this.mav.addObject("bean", bean) ;
		this.mav.setViewName(super.getpage); 
		return this.mav ;
	}
}