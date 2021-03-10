package seller.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import common.controller.SuperClass;
import dao.SellerDao;


@Controller
public class SellLogoutController extends SuperClass{
	private final String command = "/sellLogout.se";
	private final String redirect = "redirect:/main.co";
	
	private ModelAndView mav = null;
	
	@Autowired
	@Qualifier("sdao")
	private SellerDao sdao;
	
	/* 수정필요) 상품, 장바구니
	 * @Autowired
	 * 
	 * @Qualifier("pdao") private ProductDao pdao;
	 */
	
	public SellLogoutController() {
		super("sellLog", null);
		this.mav = new ModelAndView();
	}
	
	//사용자가 로그아웃 시도
	@GetMapping(command)
	public ModelAndView doGet(
		HttpSession session) {
		
		// 로그아웃 진행
		// 세션 영역의 모든 정보를 삭제
		session.invalidate();
		
		this.mav.setViewName(super.getpage); 
		return this.mav ;
	}
	

}
