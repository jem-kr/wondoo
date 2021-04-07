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
// 회원 탈퇴에 대한 컨트롤러입니다.
@Controller
public class SellDelController extends SuperClass{
	private final String command = "/sellDel.se" ; 
	private final String redirect = "redirect:/main.co" ; 
	
	private ModelAndView mav = null ; 
	
	@Autowired
	@Qualifier("sdao") 
	private SellerDao sdao ;
	
	public SellDelController() {
		super("sellDel", null);  
		this.mav = new ModelAndView();
	}
	
	@GetMapping(command)
	public ModelAndView doGet(
		@RequestParam(value = "sell_Email", required = true) String sell_Email,
		HttpSession session) {
		
		// 사업자회원의 정보 1건을 조회합니다.
		Seller bean = this.sdao.SelectDataByPk(sell_Email) ;
		
		int cnt = -99999 ;
		// 회원테이블에서 해당 건에 대한 데이터를 삭제합니다.
		cnt = this.sdao.DeleteData(bean) ;
		
		// 탈퇴하는 사람에 대한 세션 정보를 완전히 비웁니다.
		session.invalidate();
		
		this.mav.setViewName(this.redirect); 
		return this.mav ;
	}
	
}