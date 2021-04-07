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

// 회원가입 관련 컨트롤러입니다.
@Controller
public class CustInsertController extends SuperClass{
	private final String command = "/custInsert.cu" ; 
	private final String redirect = "redirect:/main.co" ; 
	
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
	
	// 회원가입(custInsert.jsp) submit
	@PostMapping(command)
	public ModelAndView doPost(
		@ModelAttribute("customer") Customer customer, 
		@Valid Customer xxx,
		HttpServletRequest request, 
		HttpSession session,
		BindingResult errors, 
		@RequestParam(value = "img", required = false) MultipartFile img) {
		
		if (errors.hasErrors()) {  // 유효성 검사 실패
			System.out.println("유효성 검사 실패");
			System.out.println("errors" + errors);
			this.mav.addObject("bean", customer);
			this.mav.setViewName(super.getpage);

		} else { // 유효성 검사 통과
			if(customer.getImg().isEmpty()==false) { // IMAGE 파일 첨부한 경우
			System.out.println("유효성 검사 통과");
			System.out.println("IMAGE 파일명 : " + customer.getImg());
			// 파일 업로드
			MultipartFile multi = customer.getImg();
			String uploadPath = "/upload";
			
			// 파일이 저장될 경로 설정
			String realPath = request.getRealPath(uploadPath);
			
				try {
					File target = Utility.getUploadedFileInfo(multi, realPath);
					// 설정한 path에 파일을 저장합니다.
					multi.transferTo(target);
					
					mav.setViewName(this.redirect);
					customer.setCust_Pic(target.getName());
					
					// Bean 객체를 이용하여 해당 게시물을 추가합니다.
					// 회원테이블에 INSERT 해줍니다.
					int cnt = -99999;
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
			} else {  // IMAGE 파일 첨부하지 않은 경우
				// Bean 객체를 이용하여 해당 게시물을 추가합니다.
				int cnt = -99999;
				cnt = cdao.InsertData(customer);

				this.mav.setViewName(this.redirect);
				session.setAttribute("message", "회원가입이 완료되었습니다!");
			}
		}
		return this.mav;
	}
}