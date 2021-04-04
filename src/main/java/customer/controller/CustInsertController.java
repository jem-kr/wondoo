package customer.controller;

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
import common.controller.SuperClass;
import dao.CustomerDao;
import utility.Utility;


@Controller
public class CustInsertController extends SuperClass{
	private final String command = "/custInsert.cu" ; // 요청 커맨드(변경 요망)
	private final String redirect = "redirect:/main.co" ; // 리다이렉션(변경 요망)
	
	private ModelAndView mav = null ; 
	
	@Autowired
	@Qualifier("cdao")
	private CustomerDao cdao;
	
	public CustInsertController() {
		super("custInsert", null);
		this.mav = new ModelAndView();
	}
	
	@ModelAttribute("customer")
	public Customer some() {
		return new Customer() ;
	}
	
	@GetMapping(command)
	public ModelAndView doGet() {
		this.mav.setViewName(super.getpage);
		System.out.println("doGet메소드");
		return this.mav ;
	}
	
	@PostMapping(command)
	public ModelAndView doPost(
		@ModelAttribute("customer") Customer customer, HttpServletRequest request, HttpSession session,
		@Valid Customer xxx, BindingResult errors, @RequestParam(value = "img", required = false) MultipartFile img) {
		
		if (errors.hasErrors()) {
			System.out.println("유효성 검사 실패.");
			System.out.println(errors);
			this.mav.addObject("bean", customer);
			this.mav.setViewName(super.getpage);

		} else {
			if(customer.getImg().isEmpty()==false) {
			System.out.println("유효성 검사 통과");
			System.out.println(customer.getImg());
			MultipartFile multi = customer.getImg();
			String uploadPath = "/upload";
			String realPath = request.getRealPath(uploadPath);
			
				try {
					File target = Utility.getUploadedFileInfo(multi, realPath);
					multi.transferTo(target);
					mav.setViewName(this.redirect);
					customer.setCust_Pic(target.getName());
					int cnt = -99999;
					// Bean 객체를 이용하여 해당 게시물을 추가한다.
					cnt = cdao.InsertData(customer);
					session.setAttribute("message", "회원가입이 완료되었습니다!");
				} catch (IllegalStateException e) {
					e.printStackTrace();
					mav.setViewName("");
				} catch (Exception e) {
					e.printStackTrace();
					this.mav.setViewName(this.redirect);
					session.setAttribute("message", "회원가입이 완료되었습니다!");
				}
			}else {
				int cnt = -99999;
				// Bean 객체를 이용하여 해당 게시물을 추가한다.
				cnt = cdao.InsertData(customer);
				System.out.println();
				this.mav.setViewName(this.redirect);
				session.setAttribute("message", "회원가입이 완료되었습니다!");
			}
		}
		return this.mav;
	}
}