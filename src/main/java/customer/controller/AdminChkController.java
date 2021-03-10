package customer.controller;
//관리자가 사업자의 승인상태를 수정하는 controller

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import bean.Seller;
import common.controller.SuperClass;
import dao.SellerDao;

@Controller
public class AdminChkController extends SuperClass{
	   private final String command = "/adminChk.cu"; 
	   private final String redirect = "redirect:/admin.cu";
	   
	   // 뷰에 넘겨줄 ModelAndView 객체
	   private ModelAndView mav = null ; 
	   
	   @Autowired
	   @Qualifier("sdao")
	   private SellerDao sdao;
	   
	   public AdminChkController() {
	      super("adminChk", null); 
	      this.mav = new ModelAndView();
	   }
	   
	   @ModelAttribute("seller")
	   public Seller some() {
	      return new Seller() ;
	   }
	   
	   @GetMapping(command)
	   public ModelAndView doGet(
	         @RequestParam(value = "sell_Email", required = true) String sell_Email,
	         HttpServletRequest request
	         ) {
	      /* 회원 가입과는 달리 수정은 이전에 기입했던 정보를 읽어 들이는 부분이 필요함 */
	      HttpSession session = request.getSession();
	      
	      System.out.println("doGet메소드");
	      Seller bean = this.sdao.SelectDataByPk(sell_Email); // 사업자 정보를 찾아냄 
	      
	      System.out.println(bean);
	      mav.addObject("bean", bean);
	      mav.setViewName(super.getpage);
	      return this.mav ;
	   }
	   
	   @PostMapping(command)
		public ModelAndView doPost(
			HttpServletRequest request,
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
				seller.setSell_Status("승인");
				// 상태 수정 완료 후, 다시 페이지 이동
				this.sdao.UpdateStatusData(seller);
				
				//관리자가 사업자 승인상태를 변경후 모달창
				HttpSession session = request.getSession();
		        session.setAttribute("message", "사업자 승인상태가 변경되었습니다.");

				this.mav.setViewName(this.redirect);
			} 
			return this.mav ;
		}
	}

