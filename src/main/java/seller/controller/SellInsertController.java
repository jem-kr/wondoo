package seller.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import bean.Customer;
import bean.Seller;
import common.controller.SuperClass;
import dao.SellerDao;
import utility.Utility;
// 회원가입에 대한 컨트롤러입니다.
@Controller
public class SellInsertController extends SuperClass{
	private final String command = "/sellInsert.se" ; 
	private final String redirect = "redirect:/main.co" ;
	
	// 뷰에 넘겨줄 ModelAndView 객체
	private ModelAndView mav = null ; 
	
	@Autowired
	@Qualifier("sdao")
	private SellerDao sdao;
	
	public SellInsertController() {
		super("sellInsert", null); 
		this.mav = new ModelAndView();
	}
	
	@ModelAttribute("seller")
	public Seller some() {
		return new Seller() ;
	}
	
	@GetMapping(command)
	public ModelAndView doGet() {
		this.mav.setViewName(super.getpage); 
		System.out.println("doGet메소드");
		return this.mav ;
	}
	
	@PostMapping(command)
	public ModelAndView doPost(HttpSession session,
		@ModelAttribute("seller") Seller seller, BindingResult errors) {
		if (errors.hasErrors()) {
			System.out.println("유효성 검사에 문제가 있습니다.");
			this.mav.setViewName(super.getpage);
		} else {
			System.out.println("유효성 검사에 문제가 없습니다.");
			// 회원 가입을 한 다음, 로그인 페이지로 다시 이동합니다.
			this.sdao.InsertData(seller) ;
			this.mav.setViewName(this.redirect);
			session.setAttribute("message", "회원가입이 완료되었습니다!");
		} 
		return this.mav ;
	}

}