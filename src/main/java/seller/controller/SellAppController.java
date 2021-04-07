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
import bean.Notice;
import bean.Seller;
import common.controller.SuperClass;
import dao.SellerDao;
import utility.Utility;

@Controller
public class SellAppController extends SuperClass{
   private final String command = "/sellApp.se"; 
   private final String redirect = "redirect:/main.co";
   
   private ModelAndView mav = null ; 
   
   @Autowired
   @Qualifier("sdao")
   private SellerDao sdao;
   
   public SellAppController() {
      super("sellApp", null); 
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
      // 회원 가입과는 달리 수정은 이전에 기입했던 정보를 읽어 들이는 부분이 필요합니다.
      HttpSession session = request.getSession();
      
      System.out.println("doGet메소드");
      Seller bean = this.sdao.SelectDataByPk(sell_Email); // 사업자 정보를 1건 조회합니다.
      
      if (bean.getSell_Status().contains("신청전")) { // 신청전 상태에서만 접근할 수 있습니다.
         this.mav.addObject("bean", bean);
         this.mav.setViewName(super.getpage); 
         
      } else if(bean.getSell_Status().contains("대기중")){ // 대기중 상태에선 접근할 수 없습니다.
         session.setAttribute("message", "관리자가 승인여부를 검토하고 있습니다.");
         mav.setViewName("redirect:/main.co");
         
      } else {
         session.setAttribute("message", "이미 승인이 완료되었습니다."); // 승인 상태에선 접근할 수 없습니다.
         mav.setViewName("redirect:/main.co");
      }
      
      return this.mav ;
   }
   
   @PostMapping(command)
   public ModelAndView doPost(
		   HttpSession session,
         @ModelAttribute("seller") Seller seller,
         BindingResult errors, HttpServletRequest request,
         @RequestParam(value = "oldimg", required = false) String oldimg){
      
      System.out.println(this.getClass() + " doPost 메소드");
      System.out.println("빈 객체 정보");
      System.out.println(seller.toString());
      System.out.println("지울 이미지 : " + oldimg); // 지워야 할 이미지 정보
      
      if ( errors.hasErrors() ) {
         System.out.println("유효성 검사 실패.");
         System.out.println( errors );
         this.mav.addObject("bean", seller); 
        session.setAttribute("message", "입력 값을 다시 확인해주세요!");

         this.mav.setViewName(super.getpage);
         
      } else {
         if(seller.getImg().isEmpty()==false) {
        	 
         System.out.println("유효성 검사 통과");
         // 파일 업로드
         MultipartFile multi = seller.getImg();
         String uploadPath ="/upload";
         String realPath = request.getRealPath(uploadPath);
         
         try {
            String del_img = realPath+"/"+oldimg;
            new File(del_img).delete();
            
            File target = Utility.getUploadedFileInfo(multi, realPath);
            multi.transferTo(target);
            
            seller.setSell_Pic(target.getName());
            seller.setSell_Status("대기중");
            
            int cnt =-999999;
            // 승인전 상태의 사업자회원 정보를 대기중으로,
            // 회원이 업로드한 이미지파일과 번호 등등 데이터를 업데이트합니다.
            cnt = this.sdao.UpdateSellApp(seller) ;
            mav.setViewName(this.redirect);
            
            } catch (IllegalStateException e) {
               e.printStackTrace();
               mav.setViewName("");
            } catch (Exception e) {
               e.printStackTrace();
               this.mav.setViewName(this.redirect);
		        session.setAttribute("message", "사업자 승인 신청이 완료되었습니다.");

            }
	         	} else {
	         		
	         	// 만약 추후 관리자의 판단으로 수정이 필요하여 이미 승인된 회원을 다시 승인전으로 변경했을 경우,
	         	// 사업자회원은 재접근할 수 있으며, 이때 수정한 데이터를 다시 업데이트합니다.
	            seller.setSell_Pic(oldimg);
	            seller.setSell_Status("대기중");
	
	            int cnt =-999999;
	            cnt = this.sdao.UpdateSellApp(seller) ;
	            
	            session = request.getSession();
	
	            mav.setViewName(this.redirect);
		        session.setAttribute("message", "사업자 승인 신청이 완료되었습니다.");
	            
	         }
      }         
      return this.mav ;
   }

}