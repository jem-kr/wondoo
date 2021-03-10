package customer.controller;

import java.io.File;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import bean.Customer;
import common.controller.SuperClass;
import dao.CustomerDao;
import utility.Utility;

	@Controller 
	public class CustUpdateController extends SuperClass{
		private final String command = "/custUpdate.cu"; 
		private final String redirect = "redirect:/main.co";
		
		// 뷰에 넘겨줄 ModelAndView 객체
		private ModelAndView mav = null ; 
		
		@Autowired
		@Qualifier("cdao") 
		private CustomerDao cdao;
		
		public CustUpdateController() {
			super("custUpdate", null);  
			this.mav = new ModelAndView();
		}
		
		@ModelAttribute("customer")
		public Customer some() {
			return new Customer() ;
		}
		
		@GetMapping(command)
		public ModelAndView doGet(
				@RequestParam(value = "cust_Email", required = true) String cust_Email) {
			/* 회원 가입과는 달리 수정은 이전에 기입했던 정보를 읽어 들이는 부분이 필요함 */
			System.out.println("doGet메소드");
			Customer bean = cdao.SelectDataByPk(cust_Email);
			this.mav.addObject("bean", bean);
			this.mav.setViewName(super.getpage);
			return this.mav ;
		}
		
		@PostMapping(command)
		public ModelAndView doPost(
			HttpSession session,
			@ModelAttribute("customer") Customer customer,
			BindingResult errors, HttpServletRequest request,
			@RequestParam( value = "oldimg",required = false) String oldimg) {
			
			System.out.println(this.getClass() + " doPost 메소드");
			System.out.println("빈 객체 정보");
			System.out.println(customer.toString());
			System.out.println("지울 이미지 : " + oldimg); //지워야 할 이미지 정보
			
			if ( errors.hasErrors() ) {
				System.out.println("유효성 검사 실패.");
				System.out.println( errors );
				this.mav.addObject("bean", customer);	
				this.mav.setViewName(super.getpage);
				
			} else {
				if(customer.getImg().isEmpty()==false) {
				System.out.println("유효성 검사 통과");
				MultipartFile multi = customer.getImg();
				String uploadPath ="/upload";
				String realPath = request.getRealPath(uploadPath);
				try {
					String del_img = realPath+"/" + oldimg;
					new File(del_img).delete();
					File target = Utility.getUploadedFileInfo(multi, realPath);
					multi.transferTo(target);
					customer.setCust_Pic(target.getName());
					int cnt = -999999;
					cnt = this.cdao.UpdateData(customer) ;
					session.setAttribute("message", "회원정보수정이 완료되었습니다.");
					mav.setViewName(this.redirect);
				} catch (IllegalStateException e) {
					e.printStackTrace();
					mav.setViewName("");
				}catch (Exception e) {
					e.printStackTrace();
					this.mav.setViewName(this.redirect);
				}
				}else {
					int cnt =-999999;
					cnt = this.cdao.UpdateData(customer);
					mav.setViewName(this.redirect);
				}
			}			
			return this.mav ;
		}
	}
