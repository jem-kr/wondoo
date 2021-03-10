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

@Controller
public class CustDetailController extends SuperClass {
	private final String command = "/custDetail.cu" ; // 요청 커맨드(변경 요망)
	private final String redirect = "redirect:/xxx.me" ; // 리다이렉션(변경 요망)
	
	private ModelAndView mav = null ; 
	
	@Autowired
	@Qualifier("cdao") // (변경 요망)
	private CustomerDao cdao ;// (변경 요망)
	
	public CustDetailController() {
		super("custDetail", null);
		this.mav = new ModelAndView();
	}
	
	@GetMapping(command)
	public ModelAndView doGet(
		@RequestParam(value = "cust_Email", required = false) String cust_Email) {
		Customer bean = this.cdao.SelectDataByPk(cust_Email) ;
		this.mav.addObject("bean", bean) ;
		this.mav.setViewName(super.getpage); 
		return this.mav ;
	}
}