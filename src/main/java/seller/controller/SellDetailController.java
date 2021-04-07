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
// 회원 정보 상세에 대한 컨트롤러입니다.
@Controller
public class SellDetailController extends SuperClass {
	private final String command = "/sellDetail.se" ;  
	private final String redirect = "redirect:/xxx.me" ; 
	
	private ModelAndView mav = null ; 
	
	@Autowired
	@Qualifier("sdao") 
	private SellerDao sdao ;
	
	public SellDetailController() {
		super("sellDetail", null);
		this.mav = new ModelAndView();
	}
	
	@GetMapping(command)
	public ModelAndView doGet(
		@RequestParam(value = "sell_Email", required = false) String sell_Email) {
		// 회원 이메일을 통해 1건의 회원 정보를 조회합니다.
		Seller bean = this.sdao.SelectDataByPk(sell_Email) ;
		this.mav.addObject("bean", bean) ;
		this.mav.setViewName(super.getpage); 
		return this.mav ;
	}
}