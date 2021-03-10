package seller.controller;

import javax.servlet.http.HttpSession;

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
public class SellDelController extends SuperClass{
	private final String command = "/sellDel.se" ; // 요청 커맨드(변경 요망)
	private final String redirect = "redirect:/main.co" ; // 리다이렉션(변경 요망)
	
	// 뷰에 넘겨줄 ModelAndView 객체
	private ModelAndView mav = null ; 
	
	@Autowired
	@Qualifier("sdao") // (변경 요망)
	private SellerDao sdao ;// (변경 요망)
	
	public SellDelController() {
		// (변경 요망)
		super("sellDel", null); // super(getpage, postpage)  
		this.mav = new ModelAndView();
	}
	
	@GetMapping(command)
	public ModelAndView doGet(
		@RequestParam(value = "sell_Email", required = true) String sell_Email,
		HttpSession session) {
		
		Seller bean = this.sdao.SelectDataByPk(sell_Email) ;
		
		int cnt = -99999 ;
		cnt = this.sdao.DeleteData(bean) ;
		
		// 탈퇴하는 사람에 대한 세션 정보를 완전히 비웁니다.
		session.invalidate();
		
		this.mav.setViewName(this.redirect); 
		return this.mav ;
	}
	
}