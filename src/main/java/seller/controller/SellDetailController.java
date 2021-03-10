package seller.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bean.Seller;
import common.controller.SuperClass;
import dao.SellerDao;

@Controller
public class SellDetailController extends SuperClass {
	private final String command = "/sellDetail.se" ; // 요청 커맨드(변경 요망)
	private final String redirect = "redirect:/xxx.me" ; // 리다이렉션(변경 요망)
	
	private ModelAndView mav = null ; 
	
	@Autowired
	@Qualifier("sdao") // (변경 요망)
	private SellerDao sdao ;// (변경 요망)
	
	public SellDetailController() {
		super("sellDetail", null);
		this.mav = new ModelAndView();
	}
	
	@GetMapping(command)
	public ModelAndView doGet(
		@RequestParam(value = "sell_Email", required = false) String sell_Email) {
		Seller bean = this.sdao.SelectDataByPk(sell_Email) ;
		this.mav.addObject("bean", bean) ;
		this.mav.setViewName(super.getpage); 
		return this.mav ;
	}
}