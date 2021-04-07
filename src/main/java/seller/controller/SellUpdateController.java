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
// 회원 정보 수정에 대한 컨트롤러입니다.
	@Controller 
	public class SellUpdateController extends SuperClass{
		private final String command = "/sellUpdate.se";
		private final String redirect = "redirect:/main.co"; 
		
		private ModelAndView mav = null ; 
		
		@Autowired
		@Qualifier("sdao") 
		private SellerDao sdao;
		
		public SellUpdateController() {
			super("sellUpdate", null);  
			this.mav = new ModelAndView();
		}
		
		@ModelAttribute("seller")
		public Seller some() {
			return new Seller() ;
		}
		
		@GetMapping(command)
		public ModelAndView doGet(
				@RequestParam(value = "sell_Email", required = true) String sell_Email) {
			// 회원 가입과는 달리 수정은 이전에 기입했던 정보를 읽어 들이는 부분이 필요합니다.
			System.out.println("doGet메소드");
			Seller bean = this.sdao.SelectDataByPk(sell_Email);
			// 이메일을 통해 1건의 회원 정보를 조회합니다.
			this.mav.addObject("bean", bean);
			this.mav.setViewName(super.getpage); 
			return this.mav ;
		}
		
		@PostMapping(command)
		public ModelAndView doPost(
			HttpSession session,				
			@ModelAttribute("seller") Seller seller,
			BindingResult errors) {
			
			System.out.println(this.getClass() + "doPost메소드");
			System.out.println(seller.toString());
			
			if (errors.hasErrors()) {
				System.out.println("유효성 검사 실패");
				System.out.println(errors);
				this.mav.addObject("bean", seller);
				this.mav.setViewName(super.getpage);
			} else {
				System.out.println("유효성 검사 통과");
				// 회원정보수정 완료 후, 다시 회원정보수정 페이지로 이동
				// 수정된 데이터를 회원테이블에 업데이트합니다.
				this.sdao.UpdateData(seller);
				session.setAttribute("message", "회원정보수정이 완료되었습니다.");
				this.mav.setViewName(this.redirect);
			} 
			return this.mav ;
		}
	}
